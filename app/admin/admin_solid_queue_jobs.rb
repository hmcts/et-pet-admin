ActiveAdmin.register_page 'Solid Queue Jobs' do
  content do
    div class: 'active-admin-solid-queue' do
      iframe src: '/admin/solid_queue_jobs_frame'
    end
  end
end