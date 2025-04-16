ActiveAdmin.register Order do
  # 👇 Optional filters or config

  index do
    selectable_column
    id_column
    column :created_at

    column "Buyer" do |order|
      if order.user
        "User: #{order.user.email}"
      elsif order.customer
        "Guest: #{order.customer.name} (#{order.customer.email})"
      else
        "Unknown"
      end
    end

    column "Beats" do |order|
      order.order_items.map do |item|
        "#{item.beat.title} ×#{item.quantity}"
      end.join(", ").html_safe
    end

    column :tax
    column :total
    actions
  end

  show do
    attributes_table do
      row :id
      row :created_at

      row "Buyer" do |order|
        if order.user
          "User: #{order.user.email}"
        elsif order.customer
          "Guest: #{order.customer.name} (#{order.customer.email})"
        else
          "Unknown"
        end
      end

      row "Beats" do |order|
        ul do
          order.order_items.each do |item|
            li "#{item.beat.title} ×#{item.quantity}"
          end
        end
      end

      row :tax
      row :total
    end
  end
end
