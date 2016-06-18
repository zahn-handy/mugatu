# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mugatu/version"

Gem::Specification.new do |spec|
  spec.name          = "mugatu"
  spec.version       = Mugatu::VERSION
  spec.authors       = ["Zach Ahn"]
  spec.email         = ["zahn@handy.com"]

  spec.summary       = %q(Selectively run linters)
  spec.description   = %q(Mugatu reports linter errors only on changes that you made)
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = %(TODO: Set to "http://mygemserver.com")
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         =
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.post_install_message =
    "MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMCO?7MMMMMMMMMMMM\n" \
    "MMMMMMMMMMMMMMM???CMMCCMMMMMMMMMMMMMMMC$C7CC$OO$???C?MMMMMMM\n" \
    "MMMMMMMMMM7?CC????COOOOC?MMMMMMMMMMMMOOC7?C77?COOOOOOMMMMMMM\n" \
    "MMMMMMM???>7CC?CO7?OOOOCCCCMMMMMMMMMMMCO?7?!7?Q$OCOOOOCMMMMM\n" \
    "MMMMMM?C????7>CO??7CCO$$O$MMMMMMMMMO$$OO?7OOC?COCC$O$OCMMMMM\n" \
    "MMMMMMM7:>???CCC7$CCO$$O?7?C$$QQQ$$$CO$$CC$$OCCOOCO$$$$OOOCM\n" \
    "MMMMM77C>?7::7OC>!7$O?7?77?7C$QHN$CCCO$Q>?$Q$O?CCO$CCOO$Q?CC\n" \
    "MMQOO7????7!>CCC??>7C?OHQCCOC?O$O?OC$$OQ$C?O$OOOQQ$$OOOCOO$C\n" \
    "M7!???7?OO>>?7>?7?!>7:>$$OOO??OCOCC!!O77COOQQOOCQQ$O$$Q$$$O$\n" \
    "M??>>!>7?C??>>!>7777>-:C??7777?7?C?7>7OOO7:?$OO$$$QQQHQO$$$M\n" \
    "7!77?>7>7>77?C>!!!!:-!7>>>>>>777????CC?CCCC$$$HQQ$Q$QQ$QOOMM\n" \
    "M?OO?77>???7!!7?>!>77!!!!!!!>77?7?7???CCCO$$$$$Q$QQ$$Q$$$QMM\n" \
    "MMMM??77??>!7??>!!!!>>>>>7>77>7?77?7C??CCOO$O$$$$$QHQ$$$$QMM\n" \
    "MMMM>7?7?7!77!7!!>>7777>>777>!>7>77?O$QQQQQ$$$$$$$$$$$Q$$CMM\n" \
    "MMMM7CC77?777>7!>>?CO$$Q$$OC?7>7?C$$$QQ$$QQQQ$$$$$$QQQQQOMMM\n" \
    "MMMMMM?C???77>>!>CC??CO$Q$$C>>>7C$HHNNNNNNH$$$$$$QQQQQQQ$MMM\n" \
    "MMMMMMMMM?777>7>7CO$$$HHHHQOC>>COQQHNQHQQHNHQ$$$QQQQQQQMMMMM\n" \
    "MMMMMMMMMM????7>!>7OQCCNQQHO>>?C$$QHHHHQHH$$$O$$$$QQQHMMMMMM\n" \
    "MMMMMMMMMM?77?7>!>!>77??C?>>!>?$$$$OOOO$OOOOOO$$$QHQ$$CMMMMM\n" \
    "MMMMMMMMMMM??C>>!!!>77777>>>>77C$$$OOOOCCCCOO$O$$$HQOOMMMMMM\n" \
    "MMMMMMMMMMM>7O>!!>!!>777777>!!!7C$$$$$$CC???C$$$$$$$H$MMMMMM\n" \
    "MMMMMMMMMMM7O?7>>>-:!7?C>7?O$??OQQQQ$OOOOCCCOO$$$$QOOOMMMMMM\n" \
    "MMMMMMMMMMM7!!7>>>>>7CO!>>>!>>>77?CCOO$O$$COO$$$$$QOCMMMMMMM\n" \
    "MMMMMMMMMMMM>!7>!>>>C$>>>!!!>>>77?CCOO$OOO$CO$OO$Q$MMMMMMMMM\n" \
    "MMMMMMMMMMMMMM77>>!7$?777C?777>CCC?CCQHQ$OO?OOOO$QMMMMMMMMMM\n" \
    "MMMMMMMMMMMMMMM7>>>7C?$ONMNHMMMMMNNMMMMQOC??C$$O$$MMMMMMMMMM\n" \
    "MMMMMMMMMMMMMMMM7>>>7$O?QMMNQQHNHQ$QNMM$$C7?O$$$$MMMMMMMMMMM\n" \
    "MMMMMMMMMMMMMMMM77>>7CC77HN$??OOC?OQ$QOOOC?C$$$$$MMMMMMMMMMM\n" \
    "MMMMMMMMMMMMMMMMM>>>>?C7>7?CCC7?OOO$$O$OOOC$$$$MMMMMMMMMMMMM\n" \
    "MMMMMMMMMMMMMMMMMM>>>>7?77>>>7???COO$$$$OO$$$$MMMMMMMMMMMMMM\n" \
    "MMMMMMMMMMMMMMMMMMM>!>!!>7777??7CCOO$OCOOO$$$MMMMMMMMMMMMMMM\n" \
    "MMMMMMMMMMMMMMMMMMMM>!!!!>>7>>>77??CCC?C?O$OMMMMMMMMMMMMMMMM\n" \
    "MMMMMMMMMMMMMMMMMMMMMM!-:!!>>>>>>7?CCCC?COMMMMMMMMMMMMMMMMMM\n" \
    "I FEEL LIKE I'M MMMMMMMM-;;--:!:::>7?7>7MMMMMMMMMMMMMMMMMMMM\n" \
    "TAKING CRAZY PILLS MMMMMMMM:::;;-:!>77MMMMMMMMMMMMMMMMMMMMMM\n"

  spec.add_runtime_dependency "rubocop", "~> 0.30"
  spec.add_runtime_dependency "rainbow", ">= 1.99.1", "< 3.0"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry-byebug", "~> 3.3"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "listen", "~> 3.0", "< 3.1"
  spec.add_development_dependency "cocaine", "~> 0.5"
end
