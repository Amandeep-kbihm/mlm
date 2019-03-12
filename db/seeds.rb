# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(name: 'Jagjot Singh',
                    email: 'firangistan@gmail.com',
                    refer_id: 'PARRY',
                    password: 'parry123',
                    address: 'Jagat Colony',
                    country: 'India',
                    state: 'Punjab',
                    city: 'Khanna',
                    status: true,
                    dob: '1993-10-30',
                    mobile_number: '9023697679',
                    sponsor_id: 'UNKNOWN',
                    otp: '123456'
)

if user
  user.add_role :admin
end

Setting.create([
                   {
                       name: 'ppv_limit',
                       value: 10,
                       kind: Setting::SETTING_KIND[:integer]
                   },
                   {
                       name: 'ppv2_limit',
                       value: 10,
                       kind: Setting::SETTING_KIND[:integer]
                   },
                   {
                       name: 'ppc_limit',
                       value: 10,
                       kind: Setting::SETTING_KIND[:integer]
                   },
                   {
                       name: 'ppv_amount',
                       value: 1,
                       kind: Setting::SETTING_KIND[:float]
                   },
                   {
                       name: 'ppv2_amount',
                       value: 1,
                       kind: Setting::SETTING_KIND[:float]
                   },
                   {
                       name: 'ppi_amount',
                       value: 1,
                       kind: Setting::SETTING_KIND[:float]
                   },
                   {
                       name: 'ppc_amount',
                       value: 1,
                       kind: Setting::SETTING_KIND[:float]
                   },
                   {
                       name: 'refer_amount',
                       value: 1,
                       kind: Setting::SETTING_KIND[:float]
                   },
                   {
                       name: 'ppc_boost_limit',
                       value: 20,
                       kind: Setting::SETTING_KIND[:float]
                   },
                   {
                       name: 'ppv_boost_limit',
                       value: 10,
                       kind: Setting::SETTING_KIND[:float]
                   },
                   {
                       name: 'ppv2_boost_limit',
                       value: 10,
                       kind: Setting::SETTING_KIND[:float]
                   },
                   {
                       name: 'popup_interval',
                       value: 60000,
                       kind: Setting::SETTING_KIND[:integer]
                   },
                   {
                       name: 'min_app_version',
                       value: 1.7,
                       kind: Setting::SETTING_KIND[:float]
                   },
                   {
                       name: 'limit_devices',
                       value: false,
                       kind: Setting::SETTING_KIND[:bool]
                   }
               ]
)
