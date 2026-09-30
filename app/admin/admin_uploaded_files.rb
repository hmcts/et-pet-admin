ActiveAdmin.register UploadedFile, as: 'UploadedFiles' do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :file, :filename, :import_file_url, :import_from_key

  preserve_default_filters!
  remove_filter :file_attachment, :file_blob, :checksum

  show do
    attributes_table title: 'File Details' do
      row(:filename) { |f| link_to(f.filename, rails_storage_proxy_path(f.file, disposition: 'attachment')) if f.file.attached? }
      row :import_file_url
      row :import_from_key
      row :file_scope
      row :created_at
      row :updated_at
    end
  end

  index do
    selectable_column
    id_column
    column :filename
    column :file_scope
    column :created_at
    column :content_type
  end

  form do |f|
    f.inputs do
      f.input :filename
      f.input :import_file_url
      f.input :import_from_key
      f.input :file_scope
      f.input :file, as: :file
    end
    f.actions

  end

  action_item :delete_file_from_storage, only: :show, if: ->() { authorized? :delete_file_from_storage, :uploaded_file } do
    options = {
      :class         => "active-admin-export-multiples-uploaded-file",
      "data-confirm" => 'This is for testing only and will permanently delete the file from storage only and not the db'
    }
    link_to 'Delete File From Storage', delete_file_from_storage_admin_uploaded_file_path, options
  end

  member_action :delete_file_from_storage, method: :post do
    if authorized? :delete_file_from_storage, :uploaded_file
      resource.file.blob.delete
      redirect_to admin_uploaded_file_path, notice: 'The file has been removed from storage'
    end
  end
end
