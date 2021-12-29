# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 本番環境用の処理
if Rails.env == 'production'
  Plan.create([
    { id: 1, name: "ライトプラン", sales_price: 14800, reward_price: 4000, reward_style: "ストック型（毎月）"},
    { id: 2, name: "スタンダードプラン" , sales_price: 19800, reward_price: 6000, reward_style: "ストック型（毎月）"},
    { id: 3, name: "プレミアムプラン" , sales_price: 27800, reward_price: 10000, reward_style: "ストック型（毎月）"},
  ])

  # (1..2).each do |i|
  #   id = 1
  #   Agency.create(
  #     id: id,
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
  #   )
  #   id += 1
  #   (1..3).each do |j|
  #     Agency.create(
  #       id: id,
  #       password: "12345678",
  #       parent_agency_id: "Q#{sprintf("%02d", i)}-000",
  #       agency_id: "Q#{sprintf("%02d", i)}-#{sprintf("%03d", j)}",
  #       company_type: "法人",
  #       agency_name: "傘下代理店#{i}-#{j}",
  #       agency_postal: "100-0005",
  #       agency_add: "東京都千代田区丸の内1丁目",
  #       agency_tel: "05020161600",
  #       agency_rec_name: "山田太郎",
  #       agency_rec_tel: "05020161601",
  #       agency_mail: "dairiten.#{i}_#{j}@test.com",
  #       bank_name: "三井住友銀行",
  #       bank_code: "0009",
  #       bank_branch_name: "本店",
  #       bank_branch_code: "001",
  #       bank_account_type: "普通預金",
  #       bank_account_number: "1234567",
  #       bank_account_holder_kana: "ヤマダ　タロウ"
  #     )
  #     id += 1
  #   end
  # end

  #   (1..3).each do |i|
  #     @company = Company.create(
  #       id: i,
  #       company_type: "法人",
  #       corp_name: "株式会社QRfood(#{i})",
  #       corp_postal: "100-0005",
  #       corp_add: "東京都千代田区丸の内1丁目",
  #       corp_add_kana: "トウキョウトチヨダクマルノウチ1チョウメ",
  #       corp_tel: "0311112222",
  #       corp_fax: "0311112223",
  #       corp_date: 20200101,
  #       rep_post: "代表取締役",
  #       rep_name: "山田太郎",
  #       rep_name_kana: "ヤマダタロウ",
  #       rep_postal: "100-0005",
  #       rep_add: "東京都千代田区丸の内1丁目",
  #       rep_add_kana: "トウキョウトチヨダクマルノウチ1チョウメ",
  #       rep_birthdate: 20200101,
  #       rep_tel: "09011112222",
  #       rep_email: "tanakataro.#{i}@test.com"
  #     )
  #     Store.create(
  #       id: i,
  #       agency_id: "Q01-#{sprintf("%03d", i)}",
  #       agency_per_name: "山田太郎",
  #       company_id: @company.id,
  #       store_name: "店舗#{i}",
  #       store_name_kana: "テンポ#{i}",
  #       alphabet_notation: "Store_#{i}",
  #       store_postal: "100-0005",
  #       store_add: "東京都千代田区丸の内1丁目",
  #       store_add_kana: "トウキョウトチヨダクマルノウチ1チョウメ",
  #       store_tel: "0333334444",
  #       store_fax: "0333334445",
  #       store_email: "store_#{i}@test.com",
  #       per_post: "店長",
  #       per_name: "山田太郎",
  #       per_name_kana: "ヤマダタロウ",
  #       per_tel: "08011112222",
  #       per_email: "yamadataro@test.com",
  #       time_zone_to_contact: "平日14時〜16時",
  #       genre: "和食",
  #       business_hours: "平日10時〜20時",
  #       regular_holiday: "土日祝",
  #       hp: "https://tabelog.com/",
  #       ave_price: 5000,
  #       reservation: "可",
  #       table_cnt: 10,
  #       counter_cnt: 10,
  #       menu_cnt: 10,
  #       menu_photo_cnt: 10,
  #       bank_name: "三井住友銀行",
  #       bank_code: "0009",
  #       bank_branch_name: "本店",
  #       bank_branch_code: "001",
  #       bank_account_type: "普通預金",
  #       bank_account_number: "1234567",
  #       bank_account_holder_kana: "ヤマダ　タロウ",
  #       plan_id: i,
  #       plan_settlement: "有",
  #       agreement: true
  #     )
  #   end

end

# 開発環境用の処理
if Rails.env == 'development'

  Plan.create([
    { name: "ライトプラン", sales_price: 14800, reward_price: 4000, reward_style: "ストック型（毎月）"},
    { name: "スタンダードプラン" , sales_price: 19800, reward_price: 6000, reward_style: "ストック型（毎月）"},
    { name: "プレミアムプラン" , sales_price: 27800, reward_price: 10000, reward_style: "ストック型（毎月）"},
  ])

  (1..5).each do |i|
    # 【Q??-000】親代理店グループ集計用
    Agency.create(
      password: "qrfoodjapan",
      parent_agency_id: "parent",
      agency_id: "Q0#{i}-000",
      company_type: "parent",
      agency_name: "parent",
      agency_postal: "123-4567",
      agency_add: "parent",
      agency_tel: "1234567890",
      agency_rec_name: "parent",
      agency_rec_tel: "1234567890",
      agency_mail: "parent@parent.parent",
      bank_name: "parent",
      bank_code: "1234",
      bank_branch_name: "parent",
      bank_branch_code: "123",
      bank_account_type: "parent",
      bank_account_number: "1234567",
      bank_account_holder_kana: "parent"
    )
    # 【Q??-001】親代理店用
    Agency.create(
      password: "12345678",
      parent_agency_id: "Q0#{i}-000",
      agency_id: "Q0#{i}-001",
      company_type: "法人",
      agency_name: "親代理店#{i}",
      agency_postal: "100-0005",
      agency_add: "東京都千代田区丸の内1丁目",
      agency_tel: "05020161600",
      agency_rec_name: "山田太郎",
      agency_rec_tel: "05020161601",
      agency_mail: "agency.#{i}@test.com",
      bank_name: "三井住友銀行",
      bank_code: "0009",
      bank_branch_name: "本店",
      bank_branch_code: "001",
      bank_account_type: "普通預金",
      bank_account_number: "1234567",
      bank_account_holder_kana: "ヤマダ　タロウ"
    )
    # 【Q??-002~】傘下代理店用
    (2..20).each do |j|
      Agency.create(
        password: "12345678",
        parent_agency_id: "Q0#{i}-000",
        agency_id: "Q0#{i}-#{sprintf("%03d", j)}",
        company_type: "法人",
        agency_name: "傘下代理店#{i}-#{j-1}",
        agency_postal: "100-0005",
        agency_add: "東京都千代田区丸の内1丁目",
        agency_tel: "05020161600",
        agency_rec_name: "山田太郎",
        agency_rec_tel: "05020161601",
        agency_mail: "agency.#{i}_#{j-1}@test.com",
        bank_name: "三井住友銀行",
        bank_code: "0009",
        bank_branch_name: "本店",
        bank_branch_code: "001",
        bank_account_type: "普通預金",
        bank_account_number: "1234567",
        bank_account_holder_kana: "ヤマダ　タロウ"
      )
    end
  end  

  (1..500).each do |i|
    @company = Company.create(
      company_type: "法人",
      corp_name: "株式会社QRfood(#{i})",
      corp_postal: "100-0005",
      corp_add: "東京都千代田区丸の内1丁目",
      corp_add_kana: "トウキョウトチヨダクマルノウチ1チョウメ",
      corp_tel: "0311112222",
      corp_fax: "0311112223",
      corp_date: 20200101,
      rep_post: "代表取締役",
      rep_name: "山田太郎",
      rep_name_kana: "ヤマダタロウ",
      rep_postal: "100-0005",
      rep_add: "東京都千代田区丸の内1丁目",
      rep_add_kana: "トウキョウトチヨダクマルノウチ1チョウメ",
      rep_birthdate: 20200101,
      rep_tel: "09011112222",
      rep_email: "yamada.#{i}@test.com"
    )
    agency_charge_id = "Q01-#{sprintf("%03d", rand(1..20))}"
    Store.create(
      agency_charge_id: agency_charge_id,
      agency_id: Agency.where(agency_id: agency_charge_id).first.id,
      agency_per_name: "山田太郎",
      company_id: @company.id,
      store_name: "店舗#{i}",
      store_name_kana: "テンポ#{i}",
      alphabet_notation: "Store_#{i}",
      store_postal: "100-0005",
      store_add: "東京都千代田区丸の内1丁目",
      store_add_kana: "トウキョウトチヨダクマルノウチ1チョウメ",
      store_tel: "0333334444",
      store_fax: "0333334445",
      store_email: "store_#{i}@test.com",
      per_post: "店長",
      per_name: "山田太郎",
      per_name_kana: "ヤマダタロウ",
      per_tel: "08011112222",
      per_email: "yamada@test.com",
      time_zone_to_contact: "平日14時〜16時",
      genre: "和食",
      business_hours: "平日10時〜20時",
      regular_holiday: "土日祝",
      hp: "https://tabelog.com/",
      ave_price: 5000,
      reservation: "可",
      table_cnt: 10,
      counter_cnt: 10,
      bank_name: "三井住友銀行",
      bank_code: "0009",
      bank_branch_name: "本店",
      bank_branch_code: "001",
      bank_account_type: "普通預金",
      bank_account_number: "1234567",
      bank_account_holder_kana: "ヤマダ　タロウ",
      plan_id: rand(1..3),
      agreement: true,
      agreement_up: true,
    )
  end
end