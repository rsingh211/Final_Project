ActiveAdmin.register Beat do
  permit_params :title, :description, :genre, :price, :license_type, :category_id

  # Filters
  filter :title
  filter :genre
  filter :price
  filter :license_type
  filter :category
  filter :created_at
  filter :updated_at

  # Index View
  index do
    selectable_column
    id_column
    column :title
    column :description
    column :genre
    column :price
    column :license_type
    column :category
    actions
  end

  # Form View
  form do |f|
    f.inputs do
      f.input :title
      f.input :description
      f.input :genre
      f.input :price
      f.input :license_type
      f.input :category
    end
    f.actions
  end
end