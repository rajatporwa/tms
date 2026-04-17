module ApplicationHelper
  # Usage: breadcrumbs([{ name: "Houses", path: houses_path }, { name: "Room 1" }])
  # Last item renders as plain text (current page), others as links.
  def breadcrumbs(crumbs)
    items = crumbs.each_with_index.map do |crumb, i|
      last = (i == crumbs.length - 1)
      if last
        content_tag(:span, crumb[:name], class: "text-gray-500 font-medium")
      else
        safe_join([
          link_to(crumb[:name], crumb[:path], class: "text-blue-600 hover:text-blue-800 hover:underline transition-colors"),
          content_tag(:span, " › ", class: "text-gray-400 mx-1 select-none")
        ])
      end
    end
    content_tag(:nav, safe_join(items), aria: { label: "Breadcrumb" },
                class: "flex flex-wrap items-center gap-2 text-sm")
  end
end
