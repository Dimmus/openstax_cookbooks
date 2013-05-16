# Borrowed with modifications from Rails:
#   activesupport/lib/active_support/core_ext/object/blank.rb
#   activesupport/lib/active_support/core_ext/string/encoding.rb

class String
  NON_WHITESPACE_REGEXP = %r![^\s#{[0x3000].pack("U")}]!

  def blank?
    self !~ NON_WHITESPACE_REGEXP
  end
end

class NilClass
  def blank?
    true
  end
end