default_allowed_tags = Class.new.include(ActionText::ContentHelper).new.sanitizer_allowed_tags
default_allowed_attributes = Class.new.include(ActionText::ContentHelper).new.sanitizer_allowed_attributes

new_allowed_tags = default_allowed_tags + %w[
  iframe style table thead tbody tr th td caption colgroup col
]

new_allowed_attributes = default_allowed_attributes + %w[
  style href target id class aria-label aria-describedby aria-hidden scope colspan rowspan
]

ActionText::ContentHelper.allowed_tags = new_allowed_tags
ActionText::ContentHelper.allowed_attributes = new_allowed_attributes
