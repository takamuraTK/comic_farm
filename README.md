# ComicFarm

## 本番環境の構成図
![構成図](https://github.com/takamuraTK/comic_farm/blob/images/images/2_comic_farm_map.jpg?raw=true)

## このアプリについて
好きな漫画を登録したり、共有したり、感想を言い合ったりできるアプリです。  
また、気になる漫画の情報を入手することも可能で、例えば登録している漫画の新刊が今月に出るとしたら  
それを自動で確認することができます。  
所持している漫画の管理としても使うことができ、本屋さんに行って「この漫画何巻まで買ったっけ」みたいなことを防げたりします。

## URL
https://www.comic-farm.net/books

## 使用した技術
- Ruby 2.5.3
- Rails 5.2.2
- MySQL 5.7
- Nginx 1.11.3
- Docker 19.03.4
- docker-compose 3
- Git
- circleCI 2.0
- AWS
  - ECS
  - ECR
  - EC2
  - RDS
  - S3
  - ALB
  - Route53
  - ACM
  - VPC
- Rakuten Books API
  
## 機能一覧
- ログイン/ログアウト機能
- プロフィール編集機能
- プロフィール画像アップロード機能
- 漫画検索機能（ソート可能）
- 漫画詳細情報確認機能
- レビュー投稿/編集/削除/いいね機能
- 漫画登録機能
- 漫画お気に入り登録機能
- 登録数ランキング機能
- レビュー評価ランキング機能
- 登録漫画管理機能
- 新刊表示機能
- 所持している漫画のシリーズで、今月発売のものを表示する機能

