![ソース](https://img.shields.io/github/languages/code-size/ichihara-development-github/purchase_app)

![ソース](https://img.shields.io/badge/FW-Ruby_on_Rails-red)
![ソース](https://img.shields.io/badge/test-RSpec-blue)
![ソース](https://img.shields.io/badge/production-AWS-orange)
![ソース](https://img.shields.io/badge/deploy-CircleCI-brightgreen)


## アプリ名
Purchase_app

![スクリーンショット (60)](https://user-images.githubusercontent.com/50323412/85983157-f8dad700-ba21-11ea-8195-00fa9db263dc.png)

[>> アプリはこちら](http://3.20.24.205/)

## 概要
ECショップに見立てて商品を出品、購入ができるアプリです。

## 主要機能

### 出品

商品を新規に作成、編集、削除できます。

![スクリーンショット (81)](https://user-images.githubusercontent.com/50323412/85986685-97b60200-ba27-11ea-98ff-c886ddaddd8e.png)

![スクリーンショット (82)](https://user-images.githubusercontent.com/50323412/85986692-997fc580-ba27-11ea-918c-50c1ee454b79.png)


![スクリーンショット (83)](https://user-images.githubusercontent.com/50323412/85986700-9b498900-ba27-11ea-9404-96323ffb1b53.png)



### 購入

![スクリーンショット (62)](https://user-images.githubusercontent.com/50323412/85984289-f2e5f580-ba23-11ea-8c1f-17b96f2f9f60.png)

![スクリーンショット (63)](https://user-images.githubusercontent.com/50323412/85984160-bd410c80-ba23-11ea-9802-eb178c5962ba.png)

StripeAPIを使用してクレジットカード決済ができます。

![スクリーンショット (64)](https://user-images.githubusercontent.com/50323412/85984168-c16d2a00-ba23-11ea-87ce-ca68ab506486.png)

購入履歴はカート画面から一覧として見直すことができます、

### フォロー


![スクリーンショット (86)](https://user-images.githubusercontent.com/50323412/85987353-7dc8ef00-ba28-11ea-9169-04ca4e9e56fb.png)

フォローしたユーザーが新しい商品を出品すると通知が来るようになります。

![スクリーンショット (87)](https://user-images.githubusercontent.com/50323412/85987359-7e618580-ba28-11ea-83df-e9679bcb616d.png)



### 検索


![スクリーンショット (79)](https://user-images.githubusercontent.com/50323412/85987046-1743d100-ba28-11ea-9a83-6e83c7b2c1ae.png)
複数条件検索とキーワード検索を実装しています。

![スクリーンショット (80)](https://user-images.githubusercontent.com/50323412/85987050-190d9480-ba28-11ea-9995-46a5220967a9.png)


### 通知


![スクリーンショット (76)](https://user-images.githubusercontent.com/50323412/85987005-02ffd400-ba28-11ea-9ffd-082ee7b24095.png)

![スクリーンショット (78)](https://user-images.githubusercontent.com/50323412/85987010-04c99780-ba28-11ea-9bd7-7eb3663848df.png)

フォロー、自店舗の商品の購入、自店舗商品のカート追加、自店舗商品にコメント、フォローしているユーザーの出品時に通知が来ます。


### GoogleMap


![スクリーンショット (85)](https://user-images.githubusercontent.com/50323412/85986778-b3b9a380-ba27-11ea-8529-bf198852a199.png)

GoogleMapAPIを使って店舗の登録されている住所とユーザーの住所を取得しています。
またその直線距離に応じて送料が変動するシステムも導入しています。

### その他

- login、admin機能
- 商品並び替え（新着順、購入数順、価格順）

## 使用技術・開発環境

### 開発環境

- Ruby 2.6.5
- Rails 5.1.7

### テスト

- RuboCop 0.80.1
- RSpec 3.9

### 本番環境

- AWS
  - VPC
  - EC2
  - RDS
  - S3  

### デプロイ

- Capistrano

### その他

- CircleCI 3.12.0

- 外部API
 - Stripe(決済機能)
 - GoogleMapAPI(位置情報取得)
 - SendGrid(メール送信)
