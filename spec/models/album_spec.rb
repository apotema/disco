# -*- encoding : utf-8 -*-
require 'spec_helper'

describe Album do

  it { should validate_presence_of :name }
  
end
