module PostsHelper
  def post_types_view
    ["Job Posting", "Booth Rental", "Shop for Sale"].zip(Post.types)
  end
  
  def post_types_search_view
    {"Job Postings" => Post.types[0], "Booth Rentals" => Post.types[1], "Shops for Sale" => Post.types[2]}
  end
end
