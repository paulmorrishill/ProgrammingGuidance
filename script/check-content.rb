# Content checks that a link checker cannot make.
#
# The rule this exists for: a glossary definition lives in _data/glossary.yml and
# nowhere else. Copying one into a page creates a second copy that will drift.
#
# Run with: bundle exec ruby script/check-content.rb

require "yaml"

ROOT = File.expand_path("..", __dir__)
MAX_DEFINITION_WORDS = 20
MAX_RULES = 5

failures = []
def fail!(list, file, message)
  list << "#{file}: #{message}"
end

# ---------------------------------------------------------------- glossary

glossary_path = File.join(ROOT, "_data", "glossary.yml")
entries = YAML.safe_load(File.read(glossary_path))
seen_names = {}

entries.each_with_index do |entry, i|
  where = "_data/glossary.yml entry #{i + 1}"

  term = entry["term"]
  unless term.is_a?(String) && !term.strip.empty?
    # A bare `term: null` or `term: no` is read by YAML as a value, not a word.
    fail!(failures, where, "term is missing or is not text. Quote it, as in: term: \"null\"")
    next
  end

  short = entry["short"].to_s
  fail!(failures, where, "#{term}: short is empty") if short.strip.empty?

  words = short.split(/\s+/).length
  if words > MAX_DEFINITION_WORDS
    fail!(failures, where, "#{term}: definition is #{words} words, limit is #{MAX_DEFINITION_WORDS}")
  end

  fail!(failures, where, "#{term}: no group") if entry["group"].to_s.strip.empty?

  ([term] + Array(entry["aliases"])).each do |name|
    key = name.to_s.downcase
    if seen_names.key?(key)
      fail!(failures, where, "#{name.inspect} is already used by #{seen_names[key].inspect}")
    else
      seen_names[key] = term
    end
  end

  # A url must name a page that exists.
  url = entry["url"]
  next if url.nil?

  source = File.join(ROOT, url.sub(%r{\A/}, "").sub(%r{/\z}, "") + ".md")
  unless File.exist?(source)
    fail!(failures, where, "#{term}: url #{url} has no page at #{File.basename(source)}")
  end
end

# ---------------------------------------------------------------- pages

pages = Dir.glob(File.join(ROOT, "**", "*.md")).reject do |path|
  rel = path.sub(ROOT + File::SEPARATOR, "").tr("\\", "/")
  rel.start_with?("_site/", "vendor/", "node_modules/") || rel == "README.md" || rel == "STYLE.md"
end

def normalise(text)
  text.downcase.gsub(/\s+/, " ").strip
end

# Strip fenced code, inline code and front matter, so checks only see prose.
def prose_of(body)
  body.gsub(/```.*?```/m, " ").gsub(/`[^`]*`/, " ")
end

pages.each do |path|
  rel = path.sub(ROOT + File::SEPARATOR, "").tr("\\", "/")
  raw = File.read(path)

  match = raw.match(/\A---\s*\n(.*?)\n---\s*\n(.*)\z/m)
  unless match
    fail!(failures, rel, "no front matter")
    next
  end

  front = YAML.safe_load(match[1]) || {}
  body = match[2]
  prose = prose_of(body)

  %w[layout title].each do |key|
    fail!(failures, rel, "front matter has no #{key}") if front[key].to_s.strip.empty?
  end

  # A glossary definition must not be repeated in a page.
  haystack = normalise(prose)
  entries.each do |entry|
    short = entry["short"].to_s
    next if short.strip.empty?
    needle = normalise(short)
    next if needle.length < 25 # too short to be a meaningful duplicate
    if haystack.include?(needle)
      fail!(failures, rel, "repeats the glossary definition of #{entry["term"].inspect}. Define it in your own words, or link it.")
    end
  end

  # The style guide bans the semicolon outright.
  prose.each_line.with_index(1) do |line, n|
    next unless line.include?(";")
    next if line.start_with?("    ") # indented block
    fail!(failures, rel, "line #{n} uses a semicolon. Split the sentence.")
  end

  # A rules block holds at most five items, and every one is NEVER or ALWAYS.
  if (rules = body[/^\{:\s*\.rules\}\n((?:- .*\n)+)/, 1])
    items = rules.lines.map(&:strip).reject(&:empty?)
    if items.length > MAX_RULES
      fail!(failures, rel, "rules block has #{items.length} rules, limit is #{MAX_RULES}")
    end
    items.each do |item|
      unless item =~ /\A- \*\*(NEVER|ALWAYS)\*\*/
        fail!(failures, rel, "rule is not NEVER or ALWAYS: #{item[0, 60]}")
      end
    end
  end
end

# ---------------------------------------------------------------- report

if failures.empty?
  puts "Content checks passed. #{entries.length} glossary terms, #{pages.length} pages."
  exit 0
end

warn "Content checks failed:"
failures.each { |f| warn "  #{f}" }
warn ""
warn "#{failures.length} problem(s)."
exit 1
