ActiveAdmin.register Et1::FeatureFlag, as: 'ET1 Feature flags' do
  menu parent: 'ET1', label: 'Feature flags'

  permit_params :name, :default_value, :key, values_attributes: [:id, :_destroy, :flag_key, :value, :valid_from, :valid_to]

  form do |f|
    f.inputs "Feature Flag" do
      f.input :key, input_html: { disabled: f.object.persisted? }
      f.input :name
      f.input :default_value, label: 'Enabled by default'
    end

    f.inputs "Values" do
      f.has_many :values,
                 heading: false,
                 new_record: true,
                 allow_destroy: true do |value|
        value.input :valid_from,
                    as: :string,
                    hint: "Leave blank for immediately",
                    input_html: {
                      type: "datetime-local",
                      value: value.object.valid_from&.in_time_zone&.strftime("%Y-%m-%dT%H:%M")
                    }

        value.input :valid_to,
                    as: :string,
                    hint: "Leave blank for never expiring",
                    input_html: {
                      type: "datetime-local",
                      value: value.object.valid_to&.in_time_zone&.strftime("%Y-%m-%dT%H:%M")
                    }
        value.input :value, label: 'Enabled'
      end
    end
    f.actions
  end

  show do
    attributes_table title: 'Flag details' do
      row :key
      row :name
      row :default_value
    end

    panel "Flag values" do
      table_for resource.values do
        column :valid_from
        column :valid_to
        column :enabled
      end
    end
  end

  filter :key
  filter :name

  index title: 'Feature flags (ET1)' do
    selectable_column
    column :key
    column :name
    column :'Enabled by default', :default_value
    actions
  end
end