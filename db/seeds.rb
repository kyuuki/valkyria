# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Site.create(host: "rails-dev3.akoba.xyz", name: "開発ブログ", template: "sailor")
Site.create(host: "yutai.akoba.xyz", name: "株主優待ブログ", template: "sailor")
Site.create(host: "money.akoba.xyz", name: "副業ブログ", template: "sailor")
Site.create(host: "generate-ai.akoba.xyz", name: "生成系 AI ブログ", template: "sailor")
Site.create(host: "emacs.akoba.xyz", name: "Emacs ブログ", template: "bootstrap")

Post.create(
  title: "Rails マイグレーションガイド",
  content: "<p>リンク集のみだよ。</p>",
  posted_at: "2020-07-24 02:00")
Post.create(
  title: "日本マクドナルド",
  content: "<p>長文を書くにはやっぱり管理画面がすぐ欲しい。</p>",
  posted_at: "2020-08-09 00:00")
Post.create(
  title: "Org-mode キーバインド",
  content: "<h3>見出し</h3><p>表とか画像もさすがに入れたいな。</p>",
  posted_at: "2020-08-09 00:00")
