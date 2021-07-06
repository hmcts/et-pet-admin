ActiveAdmin.register Address, as: 'Addresses' do
    # See permitted parameters documentation:
    # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
    #
    permit_params :building, :street, :locality, :county, :post_code, :country
    #
    # or
    #
    # permit_params do
    #   permitted = [:permitted, :attributes]
    #   permitted << :other if params[:action] == 'create' && current_user.admin?
    #   permitted
    # end
    form do |f|
        f.inputs do
          f.input :building
          f.input :street
          f.input :locality
          f.input :county
          f.input :post_code
          f.input :country, as: :string
        end
        f.actions
      end
    end
    