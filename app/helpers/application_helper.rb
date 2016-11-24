module ApplicationHelper
  def full_title page_title = ""
    base_title = t :title
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def book_image book
    book.picture.url || "books.jpg"
  end
end
