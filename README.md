# Rental box

- 地域の納涼祭や大学の学園祭などを運営する際、出店団体の登録・レンタル品の注文を一括で管理するサイトです。
https://user-images.githubusercontent.com/65978449/115143752-257cdf80-a084-11eb-984a-f973621d6a73.png
https://user-images.githubusercontent.com/65978449/115143780-51986080-a084-11eb-92cc-1493c50e1c8f.png
https://user-images.githubusercontent.com/65978449/115143812-7260b600-a084-11eb-9c03-dcfde4728cad.png">


# URL
https://rental-box.work/

# 使用技術
- Ruby 2.5.7
- Ruby on Rails 5.2.5
- MySQL 5.7
- Nginx
- Puma
- AWS
  - VPC
  - EC2
  - RDS
  - ALB
  - Route53
- Docker/Docker-compose
- CircleCi CI/CD
- Capistrano3
- RSpec

# AWS構成図
![インフラ構成図 (1)](https://user-images.githubusercontent.com/65978449/114654892-13b6d780-9d26-11eb-9ac1-b188d16d340c.jpg)

## CircleCi CI/CD
- Githubへのpush時に、RspecとRubocopが自動で実行されます。
- issue1ブランチへのpushでは、RspecとRubocopが成功した場合、EC2への自動デプロイが実行されます。

# 機能一覧
- ユーザー登録、ログイン機能(devise)
- 申請内容修正機能(devise)
- 画像投稿機能(refile)
- 登録完了メール自動送信機能

# テスト