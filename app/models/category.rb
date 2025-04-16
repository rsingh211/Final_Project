class Category < ApplicationRecord
    has_many :beats
    validates :name, presence: true, uniqueness: true
    has_many :beats, dependent: :destroy
  
    # Allow searchable attributes
    def self.ransackable_attributes(auth_object = nil)
      ["id", "name", "created_at", "updated_at"]
    end
  
    # Allow searchable associations (needed for related beat searches)
    def self.ransackable_associations(auth_object = nil)
      ["beats"]
    end
  end
  
  ActiveAdmin.register Category do
    permit_params :name
  
    index do
      selectable_column
      id_column
      column :name
      column :created_at
      actions
    end
  
    filter :name
    filter :created_at
  
    form do |f|
      f.inputs do
        f.input :name
      end
      f.actions
    end
  end
  

    

  