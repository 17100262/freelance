ThinkingSphinx::Index.define :job, :with => :active_record do
  # fields
  indexes title, :sortable => true
  indexes description
  indexes category.name, :as => :category
  indexes subcategory.name, :as => :subcategory
#   indexes [author.first_name, author.last_name], as: :author_name

  # attributes
#   has author_id, published_at
  has category_id, subcategory_id
end