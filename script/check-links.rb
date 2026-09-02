# Checks every internal link and anchor in the built site.
#
# Uses only the standard library, so it behaves the same on a developer machine and
# on CI. External links are not checked, because a network failure is not a fault in
# this repository.
#
# Run with: bundle exec ruby script/check-links.rb

SITE = File.expand_path("../_site", __dir__)

abort "No _site directory. Build the site first." unless Dir.exist?(SITE)

pages = Dir.glob(File.join(SITE, "**", "*.html"))
abort "No pages found in _site." if pages.empty?

# id="..." and name="..." give the anchors a page offers.
def anchors_in(path)
  html = File.read(path)
  html.scan(/\bid="([^"]+)"/).flatten | html.scan(/<a[^>]*\bname="([^"]+)"/).flatten
end

ANCHORS = Hash.new { |h, k| h[k] = File.exist?(k) ? anchors_in(k) : [] }

# Map a link to the file that should serve it. Pretty permalinks mean a link with no
# extension is served by a directory index.
def resolve(target, from_dir)
  base = target.start_with?("/") ? File.join(SITE, target) : File.expand_path(target, from_dir)
  candidates = [base]
  candidates << File.join(base, "index.html") unless File.extname(base) == ".html"
  candidates << base + ".html" if File.extname(base).empty?
  candidates.find { |c| File.file?(c) }
end

failures = []
checked = 0

pages.each do |page|
  rel_page = page.sub(SITE + File::SEPARATOR, "").tr("\\", "/")
  html = File.read(page)
  dir = File.dirname(page)

  links = html.scan(/<a[^>]+href="([^"]*)"/).flatten
  assets = html.scan(/<(?:link|script|img)[^>]+(?:href|src)="([^"]*)"/).flatten

  (links + assets).each do |raw|
    next if raw.empty?
    next if raw.start_with?("http://", "https://", "mailto:", "data:", "//")

    path, fragment = raw.split("#", 2)
    path = path.to_s.split("?", 2).first.to_s # drop the cache-busting query

    # A bare "#thing" points inside this same page.
    if path.empty?
      next if fragment.nil? || fragment.empty?
      checked += 1
      unless anchors_in(page).include?(fragment)
        failures << "#{rel_page} -> ##{fragment} (no such anchor on this page)"
      end
      next
    end

    checked += 1
    file = resolve(path, dir)

    if file.nil?
      failures << "#{rel_page} -> #{raw} (no page or file at that address)"
      next
    end

    next if fragment.nil? || fragment.empty?
    next unless File.extname(file) == ".html"

    unless ANCHORS[file].include?(fragment)
      target = file.sub(SITE + File::SEPARATOR, "").tr("\\", "/")
      failures << "#{rel_page} -> #{raw} (#{target} has no anchor ##{fragment})"
    end
  end
end

if failures.empty?
  puts "Link checks passed. #{checked} internal links across #{pages.length} pages."
  exit 0
end

warn "Broken links:"
failures.uniq.each { |f| warn "  #{f}" }
warn ""
warn "#{failures.uniq.length} broken link(s)."
exit 1
