# FOODS APP

就職活動用のポートフォリオとして制作した自作アプリです。
お気に入りの料理の写真を投稿出来ます。機能としてはシンプルですが、開発環境にDocker、インフラにAWSを使用しています。

## URL
url
ログインページからおためしログインをクリックで、ゲストアカウントとしてログインできます

## 使用技術
* Ruby 2.6.3, Rails 5.1.6
* Nginx, unicorn
* AWS (EC2, RDS for MySQL, S3, VPC, Route53, ALB, ACM)
* Docker,Docker-compose
* CircleCi
* RSpec
* Bootstrap4,jQuery

## 機能一覧
* ユーザー登録・ログイン機能（deviseを使用）
* 投稿機能（画像のアップロードにCarrierWaveを使用）
* 投稿一覧・投稿詳細表示機能
* ページネーション機能（Kaminari）
* いいね機能（Ajax)
* 検索機能（Ransackを使用）
* フォロー・フォロワー機能
* 単体spec

## AWS構成図
![image](https://user-images.githubusercontent.com/59563038/83327203-2151a300-a2b5-11ea-9114-3c7302103dfa.png)

