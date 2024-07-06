Rails Bootstrap Theme Sailor サンプル
=====================================

[![Build status][shield-build]](#)
[![MIT licensed][shield-license]](#)
[![Rails][shield-rails]][rails]

Rails で [BootstrapMade.com][bootstrapmade] の [Sailor テンプレート](https://bootstrapmade.com/sailor-free-bootstrap-theme/) を適用してそれなりの実用的なサイトを作成するためのサンプル

フリーで利用する場合にはフッターのクレジットは削除できないのでご注意ください。

## Table of Contents

* [Technologies](#technologies)
* [How to make](#how-to-make)
* [Usage](#usage)
* [References](#references)
* [License](#license)

## Technologies

* [Rails][rails] 7.0.8.4
* [Bootstrap](https://getbootstrap.com/) 5.3.3
* [PostgreSQL][postgresql]


## How to make

### Rails アプリケーション作成

```sh
$ git clone git@github.com:kyuuki/sample-rails7-practical-base.git sample-rails7-practical-bootstrapmade-sailor
$ cd sample-rails7-practical-bootstrapmade-sailor
```

### GitHub

- GitHub に sample-rails7-practical-bootstrapmade-sailor という名前でリポジトリ追加

```sh
$ git remote set-url origin git@github.com:kyuuki/sample-rails7-practical-bootstrapmade-sailor.git
$ git push
```

### Sailor テンプレート適用

- https://bootstrapmade.com/sailor-free-bootstrap-theme/ から Zip ファイルをダウンロードして展開

- assets を public にコピー (public/assets は .gitignore に設定されているのでコミット時に注意)

- 各 html ファイルを erb ファイルに分割してコピー

- タイトルをテンプレートファイルで指定できるように  
  https://github.com/kyuuki/sample-rails7-practical-bootstrapmade-sailor/commit/b2cd7b8dd44f523ae12c7fcd5dcabcf06f609cbb

- メニューの avtive をテンプレートファイルで指定できるように  
  https://github.com/kyuuki/sample-rails7-practical-bootstrapmade-sailor/commit/444b39205e18a2088d23b6eda022bb78d0625523

- パンくずリストを共通化  
  https://github.com/kyuuki/sample-rails7-practical-bootstrapmade-sailor/commit/3f62bc68c75c5d39d68693466ee66e5fe79375ce

## Usage

```sh
$ git clone git@github.com:kyuuki/sample-rails7-practical-bootstrapmade-sailor.git
$ cd sample-rails7-practical-base
$ bundle install
$ rails db:create
$ rails s -b 0.0.0.0
```

### タイトルの変更方法

- 各テンプレートの `content_for :title` でタイトルを設定してください。  
  https://github.com/kyuuki/sample-rails-bootstrapmade-sailor/blob/master/app/views/static_page/about.html.erb#L1

### アクティブメニューの変更方法

- 各テンプレートの `content_for :menu_setting` 内で `@menu` 変数にアクティブにするメニューのシンボルを代入してください。  
  https://github.com/kyuuki/sample-rails-bootstrapmade-sailor/blob/master/app/views/static_page/about.html.erb#L3
- 各メニューのシンボルは https://github.com/kyuuki/sample-rails-bootstrapmade-sailor/blob/master/app/views/layouts/_header.html.erb の各メニューの `@menu` と比較しているシンボルを参照してください。

### パンくずリストの変更方法

- パンくずリストの部分テンプレートに `breadcrumbs` 変数を渡してください。  
  https://github.com/kyuuki/sample-rails-bootstrapmade-sailor/blob/master/app/views/layouts/_header.html.erb
- `breadcrumbs` 変数は `[ [ <パンくずリストに表示する文字列>, <パス> ] ... ]` という形式になります。配列の順に左から順番に並びます。`<パス>` に `nil` を指定するとリンクではなくなります。
- `breadcrumbs` 変数の最後の要素の `<パンくずリストに表示する文字列>` はページの見出しにも利用されます。

## References

* [Ruby on Rails Guides (v7.0.x) (英)](https://guides.rubyonrails.org/v7.0/)
* [Ruby on Rails ガイド (日)](https://railsguides.jp/)
* [Slim README (日)](https://github.com/slim-template/slim/blob/main/README.jp.md)
* [Sailor - Bootstrap Business Template](https://bootstrapmade.com/sailor-free-bootstrap-theme/)
* [Live Demo](https://bootstrapmade.com/demo/Sailor/)

## License

This is licensed under the [MIT](https://choosealicense.com/licenses/mit/) license.  
Copyright &copy; 2024 [Fuji Programming Laboratory](https://fj-lab.com/)



[rails]: https://rubyonrails.org/
[postgresql]: https://www.postgresql.org/
[bootstrapmade]: https://bootstrapmade.com/

[shield-build]: https://img.shields.io/badge/build-passing-brightgreen.svg
[shield-license]: https://img.shields.io/badge/license-MIT-blue.svg
[shield-rails]: https://img.shields.io/badge/-Rails-CC0000.svg?logo=ruby-on-rails&style=flat
