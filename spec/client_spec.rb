require "spec_helper"

describe Sysperan::Client do

  let(:redis) { Redis.connect url: "redis://localhost/3" }
  subject { Sysperan::Client.new "redis://localhost/3" }

  before(:each) do
    redis.flushdb
  end

  it "creates two entries" do
    subject.perform { true }
    expect { redis.type("sysperan::events") == "list" }
    expect { redis.llen("sysperan::events") == 2 }
    expect { JSON.parse(redis.lpop("sysperan::events")) }
  end

end
