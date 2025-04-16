ActiveAdmin.register Category do
  # Strong parameters
  permit_params :name

  # Filters
  filter :name
  filter :created_at
  filter :updated_at

  # Index page
  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  # Form
  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  # Show page
  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
    end
  end
end
