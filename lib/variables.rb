require 'variables/core_ext/module'
require 'variables/core_ext/object'
require 'variables/version'

Module.send(:include, Variables::CoreExt::Module)
Object.send(:include, Variables::CoreExt::Object)
