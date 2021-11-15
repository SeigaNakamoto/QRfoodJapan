# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env == 'development'

  Plan.create([
    { id: 1, name: "ライトプラン", sales_price: 14800, reward_price: 4000, reward_style: "ストック型（毎月）"},
    { id: 2, name: "スタンダードプラン" , sales_price: 19800, reward_price: 6000, reward_style: "ストック型（毎月）"},
    { id: 3, name: "プレミアムプラン" , sales_price: 27800, reward_price: 10000, reward_style: "ストック型（毎月）"},
  ])

  # (1..30).each do |i|
  #   Agency.create(
  #     email: "agency.#{i}@test.com",
  #     password: "12345678",
  #     parent_agency_id: "parent",
  #     agency_id: "Q#{sprintf("%02d", i)}-000",
  #     company_type: "法人",
  #     agency_name: "親代理店#{i}",
  #     agency_postal: "100-0005",
  #     agency_add: "東京都千代田区丸の内1丁目",
  #     agency_tel: "05020161600",
  #     agency_rec_name: "山田太郎",
  #     agency_rec_tel: "05020161601",
  #     agency_mail: "dairiten.#{i}@test.com",
  #     bank_name: "三井住友銀行",
  #     bank_code: "0009",
  #     bank_branch_name: "本店",
  #     bank_branch_code: "001",
  #     bank_account_type: "普通預金",
  #     bank_account_number: "1234567",
  #     bank_account_holder_kana: "ヤマダ　タロウ"
  #     )
  #     (1..9).each do |j|
  #       Agency.create(
  #         email: "agency.#{i}_#{j}@test.com",
  #         password: "12345678",
  #         parent_agency_id: "Q#{sprintf("%02d", i)}-000",
  #         agency_id: "Q#{sprintf("%02d", i)}-#{sprintf("%03d", j)}",
  #         company_type: "法人",
  #         agency_name: "傘下代理店#{j}",
  #         agency_postal: "100-0005",
  #         agency_add: "東京都千代田区丸の内1丁目",
  #         agency_tel: "05020161600",
  #         agency_rec_name: "山田太郎",
  #         agency_rec_tel: "05020161601",
  #         agency_mail: "dairiten.#{i}_#{j}@agency.com",
  #         bank_name: "三井住友銀行",
  #         bank_code: "0009",
  #         bank_branch_name: "本店",
  #         bank_branch_code: "001",
  #         bank_account_type: "普通預金",
  #         bank_account_number: "1234567",
  #         bank_account_holder_kana: "ヤマダ　タロウ"
  #       )
  #     end    
  #   end

  # (1..50).each do |i|
  #   Company.create(
  #     id: i,
  #     company_type: "法人",
  #     corp_name: "株式会社QRfood(#{i})",
  #     corp_postal: "100-0005",
  #     corp_add: "東京都千代田区丸の内1丁目",
  #     corp_add_kana: "トウキョウトチヨダクマルノウチ1チョウメ",
  #     corp_tel: "0311112222",
  #     corp_fax: "0311112223",
  #     corp_num: "0123456789101",
  #     corp_date: 20211101,
  #     rep_post: "代表取締役",
  #     rep_name: "山田太郎",
  #     rep_name_kana: "ヤマダタロウ",
  #     rep_postal: "100-0005",
  #     rep_add: "東京都千代田区丸の内#{i}丁目",
  #     rep_add_kana: "トウキョウトチヨダクマルノウチ#{i}チョウメ",
  #     rep_birthdate: 20211101,
  #     rep_tel: "09011112222",
  #     rep_email: "tanakataro.#{i}@test.com"
  #   )
  #   Store.create(
  #     agency_id: "Q01-#{sprintf("%03d", rand(0..9))}",
  #     agency_per_name: "山田太郎",
  #     company_id: i,
  #     store_name: "店舗#{i}",
  #     store_name_kana: "テンポ#{i}",
  #     alphabet_notation: "Store_#{i}",
  #     store_postal: "100-0005",
  #     store_add: "東京都千代田区丸の内1丁目",
  #     store_add_kana: "トウキョウトチヨダクマルノウチ1チョウメ",
  #     store_tel: "03-3333-4444",
  #     store_fax: "03-3333-4445",
  #     store_email: "store_#{i}@test.com",
  #     per_post: "店長",
  #     per_name: "山田太郎",
  #     per_name_kana: "ヤマダタロウ",
  #     per_tel: "08011112222",
  #     per_email: "yamadataro@test.com",
  #     time_zone_to_contact: "平日14時〜16時",
  #     genre: "和食",
  #     business_hours: "平日10時〜20時",
  #     regular_holiday: "土日祝",
  #     hp: "https://tabelog.com/",
  #     ave_price: 5000,
  #     reservation: "可",
  #     table_cnt: 10,
  #     counter_cnt: 10,
  #     menu_cnt: 10,
  #     menu_photo_cnt: 10,
  #     bank_name: "三井住友銀行",
  #     bank_code: "0009",
  #     bank_branch_name: "本店",
  #     bank_branch_code: "001",
  #     bank_account_type: "普通預金",
  #     bank_account_number: "1234567",
  #     bank_account_holder_kana: "ヤマダ　タロウ",
  #     credit_card_member_name: "TARO YAMADA",
  #     credit_card_expiry_date: "11/25",
  #     credit_card_number: "1111222233334444",
  #     plan_id: rand(1..3),
  #     plan_settlement: "有"
  #   )
  # end
end
