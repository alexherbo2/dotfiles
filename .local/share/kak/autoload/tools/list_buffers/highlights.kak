add-highlighter shared/buffer_list regions
add-highlighter shared/buffer_list/text default-region fill string
add-highlighter shared/buffer_list/property_list region '^(.+?) \K\(' '\)$' regions
add-highlighter shared/buffer_list/property_list/text default-region group
add-highlighter shared/buffer_list/property_list/text/ regex '\b\w+\b' 0:attribute
add-highlighter shared/buffer_list/property_list/text/ regex '[(),]' 0:operator
