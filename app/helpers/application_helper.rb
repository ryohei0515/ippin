module ApplicationHelper
  PER_REVIEW = 5 #レビューの1ページあたりの表示数
  PER_FOOD = 5 #フードの1ページあたりの表示数


  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "IPPIN"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
