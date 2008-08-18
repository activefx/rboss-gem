require File.dirname(__FILE__) + '/../spec_helper'

describe Boss::ResultFactory do

   news_json_result = '{"ysearchresponse":{"responsecode":"200","nextpage":"nextpage","totalhits":"344","count":"1","start":"0","resultset_news":[{"abstract":"abstract","clickurl":"clickurl","date":"2008\/08\/18","language":"en english","source":"source","sourceurl":"sourceurl","time":"09:17:29","title":"monkey_title","url":"url"}]}}'

   image_json_result = '{"ysearchresponse":{"responsecode":"200","nextpage":"http:\/\/www.example.com","totalhits":"80","count":"1","start":"0","resultset_images":[{"abstract":"more monkeys","clickurl":"http:\/\/www.example.con\/click","date":"2001\/12\/19","filename":"monkeys.jpg","format":"jpeg","height":"600","mimetype":"image\/jpeg","refererclickurl":"http:\/\/www.example.com\/ref","refererurl":"http:\/\/www.monkeys.com","size":"60900","thumbnail_height":"116","thumbnail_url":"http:\/\/monkey.com\/image\/25\/m7\/3918546506","thumbnail_width":"155","title":"monkeys.jpg","url":"http:\/\/monkey\/monkeys.jpg","width":"800"}]}}'

   web_json_result = '{"ysearchresponse":{"responsecode":"200","nextpage":"nextpage","totalhits":"344","count":"1","start":"0","resultset_web":[{"abstract":"abstract","clickurl":"clickurl","date":"2008\/08\/18","language":"en english","source":"source","sourceurl":"sourceurl","time":"09:17:29","title":"monkey_title","url":"url"}]}}'
   
   spelling_json_result = '{"ysearchresponse":{"responsecode":"200","totalhits":"1","count":"1","start":"0","resultset_spell":[{"suggestion":"giraffes"}]}}'


  it "should create a new news object from json" do
    Boss::Result::News.should_receive(:new).once

    Boss::ResultFactory.build(Boss::SearchType::NEWS, news_json_result)
  end

  it "should correctly map fields with from json to news object" do
    news_results = Boss::ResultFactory.build(Boss::SearchType::NEWS, news_json_result)

    news_results[0].title.should == "monkey_title"
  end
  
  it "should build image objects from json" do
    Boss::Result::Image.should_receive(:new).once

    Boss::ResultFactory.build(Boss::SearchType::IMAGES, image_json_result)
  end
  
  it "should build web object from json" do
    Boss::Result::Web.should_receive(:new).once

    Boss::ResultFactory.build(Boss::SearchType::WEB, web_json_result)
  end
   
  it "should build spelling object from json" do
    Boss::Result::Spell.should_receive(:new).once
    
    Boss::ResultFactory.build(Boss::SearchType::SPELL, spelling_json_result)
  end
  
end