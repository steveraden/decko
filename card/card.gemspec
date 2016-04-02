# -*- encoding : utf-8 -*-

Gem::Specification.new do |s|
  s.name = 'card'
  s.version = File.open(File.expand_path('../VERSION', __FILE__)).read.chomp
  s.authors =
    ['Ethan McCutchen', 'Lewis Hoffman', 'Gerry Gleason', "Philipp Kühl"]
  s.email = ['info@wagn.org']

  #  s.date          = '2013-12-20'
  s.summary       = 'an atomic, set-driven content engine'
  s.description   =
    'Cards are data atoms grouped into Sets to which Rules can apply. '\
    'Cards can formatted with Views and transformed with Events.'
  s.homepage      = 'http://wagn.org'
  s.license       = 'GPL'

  s.files         = `git ls-files`.split $INPUT_RECORD_SEPARATOR

  # add submodule files (seed data)
  morepaths = `git submodule --quiet foreach pwd`.split $OUTPUT_RECORD_SEPARATOR
  morepaths.each do |submod_path|
    gem_root = File.expand_path File.dirname(__FILE__)
    relative_submod_path = submod_path.gsub "#{gem_root}/", ''
    Dir.chdir(submod_path) do
      morefiles = `git ls-files`.split $OUTPUT_RECORD_SEPARATOR
      s.files += morefiles.map do |filename|
        "#{relative_submod_path}/#{filename}"
      end
    end
  end

  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  [
    ['smartname',                  '0.2.3'],
    ['uuid',                       '~> 2.3'],
    ['carrierwave',                '~> 0.10'],
    ['htmlentities',               '~> 4.3'],
    ['mini_magick',                '~> 4.2'],
    ['recaptcha',                  '~> 0.4.0'],
    # 0.4.0 is last version that doesn't require ruby 2.0
    ['coderay',                    '~> 1.0'],
    ['sass',                       '~> 3.2'],
    ['coffee-script',              '~> 2.2'],
    ['uglifier',                   '~> 2.5'],

    ['haml',                       '~> 4.0'],
    ['kaminari',                   '~> 0.16'],

    ['bootstrap-kaminari-views',   '~> 0'],
    ['diff-lcs',                   '~> 1.2'],
    # mime-types-data can be removed if we drop support for ruby 1.9.3
    ['mime-types-data',             '3.2015.1120']
  ].each do |dep|
    s.add_runtime_dependency(*dep)
  end
end
