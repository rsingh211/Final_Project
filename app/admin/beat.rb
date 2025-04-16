ActiveAdmin.register Beat do
  permit_params :title, :description, :genre, :price, :license_type, :category_id

  #action_item :delete, only: :show do
    #button_to "Delete Beat",
   #           resource_path(resource),
   #           method: :delete,
   #           data: { turbo_confirm: "Are you sure you want to delete this beat?" },
   #           class: "btn btn-danger"
  #end
  

  # Filter
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
