# Rental box

- 地域の納涼祭や大学の学園祭などを運営する際、出店団体の登録・レンタル品の注文を一括で管理するサイトです。  

![DA65A915-878B-4133-89E5-0F59EBA1F884_1_105_c](https://user-images.githubusercontent.com/65978449/115143995-2f531280-a085-11eb-8e66-02a75c53be6c.jpeg)
<img width="700" alt="EE1D4E70-C653-4A43-BC91-3DF569DB15C0" src="https://user-images.githubusercontent.com/65978449/115144186-480ff800-a086-11eb-89b0-e8efc8792200.png">
<img width="700" alt="94F68C39-E1E6-4C62-8400-388657AAD95A_1_105_c" src="https://user-images.githubusercontent.com/65978449/115144426-8528ba00-a087-11eb-9044-91735a4b98d7.jpeg">


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