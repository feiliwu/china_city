# ChinaCity 省市区级联选择

[![Build Status](https://travis-ci.org/saberma/china_city.png?branch=master)](https://travis-ci.org/saberma/china_city)

![china_city](http://cl.ly/image/3c212i1e3b1T/ScreenFlow.mp4.gif)

支持 Rails3.1, Rails3.2, Rails4.0。

请留意，Rails3.1 与 Ruby2.0 不兼容，sprockets 无法正常解析 application.js，请使用 Ruby1.9。

## 简介

这是一个基于 Rails Engine 开发的插件，为 Rails 项目增加省市区三级（或者省市 二级）选择框，可用于实现收货地址等信息的录入。

## 安装

### Gemfile

    gem 'china_city'

### app/assets/javascripts/application.js

    //= require 'jquery'
    //= require 'china_city/jquery.china_city'

### config/routes.rb

    mount ChinaCity::Engine => '/china_city'

## 使用

在页面中加入选择框

```html


```

请留意：所有选择框都要有 `city-select` class，并都包含于 class='city-group' 的 DOM 元素之下。

选择后的值为国家地区编码，如深圳市的为 `440300`，可通过调用 `ChinaCity.get('440300')` 将编码转化为城市名称。

## 贡献

```bash
git clone git@github.com:saberma/china_city.git
cd china_city
rake appraisal:install
cd spec/dummy
rails server # http://localhost:3000/china_city
```

## 测试
<%= form_for :address, url: addresses_path do |f| %>
    <div class='city-group'>
        <select name="address[province]" id="address_province" class='city-select'>
          <option value=''>--省份--</option>
          <%= options_for_select(ChinaCity.list, @address.province) %>
        </select>
        <select name="address[city]" id="address_city" class='city-select'>
          <option value=''>--城市--</option>
          <%= options_for_select(ChinaCity.list(@address.province), @address.city) %>
        </select>
        <select name="address[county]" id="address_county" class='city-select'>
          <option value=''>--地区--</option>
          <%= options_for_select(ChinaCity.list(@address.city), @address.county) %>
        </select>
        <div class="input-row">
          <label>邮编:</label>
          <%= f.number_field :zipcode, class: 'zipcode' %>
        </div>
    </div>
<% end %>
```bash
rvm use 2.0.0
rake appraisal:rails4 spec
rake appraisal:rails32 spec
rvm use 1.9.3
bundle install
rake appraisal:rails31 spec
```

## 类似项目

* https://github.com/Kehao/area_cn_select
