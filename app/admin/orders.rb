ActiveAdmin.register Order do
  # Disable filters until you want to add back only safe ones
  config.filters = false
  permit_params :status, :paid
  

  index do
    selectable_column
    id_column
    column :created_at
    column :status do |order|
      status_tag order.status, class: order.status
    end

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

  form do |f|
    f.inputs do
      f.input :status, as: :select, collection: Order::STATUSES
    end
    f.actions
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

      row "Tax Breakdown" do |order|
        province = order.user&.province || order.customer&.province
        subtotal = order.total - order.tax
        breakdown = []

        if province.present?
          breakdown << "GST: $#{(subtotal * province.gst).round(2)}" if province.gst.to_f > 0
          breakdown << "PST: $#{(subtotal * province.pst).round(2)}" if province.pst.to_f > 0
          breakdown << "HST: $#{(subtotal * province.hst).round(2)}" if province.hst.to_f > 0
          breakdown << "QST: $#{(subtotal * province.qst).round(2)}" if province.qst.to_f > 0
          breakdown.join(", ").html_safe
        else
          "No province info available"
        end
      end


      row :tax
      row :total
      row :stripe_payment_id
      

    end
  end
end
