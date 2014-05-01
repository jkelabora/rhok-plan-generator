require_relative './data_tasks'

# will exit if plan already exists (in any form)
OnceOffTemplateLoad.new('Warrandyte Template', '3113').load

# plans (by id) to preserve
# WhiteListedDataDestroyer.new.clear_out_all_plans_and_data_except_for_these_plans do
#   (18..30).to_a + [
#     Plan.find_by_name_and_postcode('Warrandyte Template', '3113')
#   ].compact.map(&:id)
# end
