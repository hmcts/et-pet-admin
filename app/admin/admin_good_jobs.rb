ActiveAdmin.register_page 'Good Jobs' do
  content do
    div class: 'active-admin-good-jobs' do
      iframe src: '/admin/good_jobs_frame'
    end
  end
end