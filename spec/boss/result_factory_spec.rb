require File.dirname(__FILE__) + '/../spec_helper'

describe Boss::ResultFactory do

  news_json_result = '{"ysearchresponse":{"responsecode":"200","nextpage":"nextpage","totalhits":"344","count":"1","start":"0","resultset_news":[{"abstract":"abstract","clickurl":"clickurl","date":"2008\/08\/18","language":"en english","source":"source","sourceurl":"sourceurl","time":"09:17:29","title":"monkey_title","url":"url"}]}}'

  image_json_result = '{"ysearchresponse":{"responsecode":"200","nextpage":"http:\/\/www.example.com","totalhits":"80","count":"1","start":"0","resultset_images":[{"abstract":"more monkeys","clickurl":"http:\/\/www.example.con\/click","date":"2001\/12\/19","filename":"monkeys.jpg","format":"jpeg","height":"600","mimetype":"image\/jpeg","refererclickurl":"http:\/\/www.example.com\/ref","refererurl":"http:\/\/www.monkeys.com","size":"60900","thumbnail_height":"116","thumbnail_url":"http:\/\/monkey.com\/image\/25\/m7\/3918546506","thumbnail_width":"155","title":"monkeys.jpg","url":"http:\/\/monkey\/monkeys.jpg","width":"800"}]}}'

  web_json_result = '{"ysearchresponse":{"responsecode":"200","nextpage":"nextpage","totalhits":"344","count":"1","start":"0","resultset_web":[{"abstract":"abstract","clickurl":"clickurl","date":"2008\/08\/18","language":"en english","source":"source","sourceurl":"sourceurl","time":"09:17:29","title":"monkey_title","url":"url"}]}}'

  spelling_json_result = '{"ysearchresponse":{"responsecode":"200","totalhits":"1","count":"1","start":"0","resultset_spell":[{"suggestion":"giraffes"}]}}'

  error_json_result = '{"Error":"true"}'

  it "should collect result objects in a result collection" do
    result_collection = Boss::ResultCollection.new
    result_collection.should_receive(:<<).once
    Boss::ResultCollection.should_receive(:new).once.and_return(result_collection)
    
    Boss::ResultFactory.build(news_json_result)
  end
  
  it "should create a new news object from json" do
    Boss::Result::News.should_receive(:new).once

    Boss::ResultFactory.build(news_json_result)
  end

  it "should correctly map fields with from json to news object" do
    news_results = Boss::ResultFactory.build(news_json_result)

    news_results[0].title.should == "monkey_title"
  end

  it "should build image objects from json" do
    Boss::Result::Image.should_receive(:new).once

    Boss::ResultFactory.build(image_json_result)
  end

  it "should build web object from json" do
    Boss::Result::Web.should_receive(:new).once

    Boss::ResultFactory.build(web_json_result)
  end

  it "should build spelling object from json" do
    Boss::Result::Spell.should_receive(:new).once

    Boss::ResultFactory.build(spelling_json_result)
  end

  it "should raise an error if json result carries an error" do
    lambda { Boss::ResultFactory.build(error_json_result) }.should raise_error(Boss::BossError)
  end

end
