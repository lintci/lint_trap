require 'spec_helper'

describe LintTrap::Language do
  describe '.all' do
    subject(:languages){described_class.all}

    it do
      is_expected.to match([
        be_a(described_class::CoffeeScript),
        be_a(described_class::CPP),
        be_a(described_class::CSS),
        be_a(described_class::Go),
        be_a(described_class::Java),
        be_a(described_class::JavaScript),
        be_a(described_class::JSON),
        be_a(described_class::Python),
        be_a(described_class::Ruby),
        be_a(described_class::SCSS)
      ])
    end
  end

  describe '.detect' do
    subject(:language){described_class.detect(file)}

    context 'when given a CoffeeScript file' do
      let(:file){fixture_path('good.coffee')}

      it{is_expected.to be_a(described_class::CoffeeScript)}
    end

    context 'when given a C++ file' do
      let(:file){fixture_path('good.cpp')}

      it{is_expected.to be_a(described_class::CPP)}
    end

    context 'when given a CSS file' do
      let(:file){fixture_path('good.css')}

      it{is_expected.to be_a(described_class::CSS)}
    end

    context 'when given a Go file' do
      let(:file){fixture_path('good.go')}

      it{is_expected.to be_a(described_class::Go)}
    end

    context 'when given a Java file' do
      let(:file){fixture_path('Good.java')}

      it{is_expected.to be_a(described_class::Java)}
    end

    context 'when given a JavaScript file' do
      let(:file){fixture_path('good.js')}

      it{is_expected.to be_a(described_class::JavaScript)}
    end

    context 'when given a JSON file' do
      let(:file){fixture_path('good.json')}

      it{is_expected.to be_a(described_class::JSON)}
    end

    context 'when given a Python file' do
      let(:file){fixture_path('good.py')}

      it{is_expected.to be_a(described_class::Python)}
    end

    context 'when given a Ruby file' do
      let(:file){fixture_path('good.rb')}

      it{is_expected.to be_a(described_class::Ruby)}
    end

    context 'when given a SCSS file' do
      let(:file){fixture_path('good.scss')}

      it{is_expected.to be_a(described_class::SCSS)}
    end

    context 'when given an unknown language file' do
      let(:file){fixture_path('lint.txt')}

      it{is_expected.to eq(described_class::Unknown.new)}
    end

    context 'when given an image' do
      let(:file){fixture_path('good.png')}

      it{is_expected.to eq(described_class::Unknown.new)}
    end

    context 'when given a known language file that is empty' do
      let(:file){fixture_path('empty.rb')}

      # Linguist can't figure out what language the empty file is
      it{is_expected.to eq(described_class::Unknown.new)}
    end
  end

  describe '.find' do
    subject(:language){described_class.find(language_name)}

    context 'when given CoffeeScript' do
      let(:language_name){'CoffeeScript'}

      it{is_expected.to be_a(described_class::CoffeeScript)}
    end

    context 'when given C++' do
      let(:language_name){'C++'}

      it{is_expected.to be_a(described_class::CPP)}
    end

    context 'when given CSS' do
      let(:language_name){'CSS'}

      it{is_expected.to be_a(described_class::CSS)}
    end

    context 'when given Go' do
      let(:language_name){'Go'}

      it{is_expected.to be_a(described_class::Go)}
    end

    context 'when given Java' do
      let(:language_name){'Java'}

      it{is_expected.to be_a(described_class::Java)}
    end

    context 'when given JavaScript' do
      let(:language_name){'JavaScript'}

      it{is_expected.to be_a(described_class::JavaScript)}
    end

    context 'when given JSON' do
      let(:language_name){'JSON'}

      it{is_expected.to be_a(described_class::JSON)}
    end

    context 'when given Python' do
      let(:language_name){'Python'}

      it{is_expected.to be_a(described_class::Python)}
    end

    context 'when given Ruby' do
      let(:language_name){'Ruby'}

      it{is_expected.to be_a(described_class::Ruby)}
    end

    context 'when given SCSS' do
      let(:language_name){'SCSS'}

      it{is_expected.to be_a(described_class::SCSS)}
    end

    context 'when given an invalid language' do
      let(:language_name){'invalid language'}

      it{is_expected.to eq(described_class::Unknown.new)}
    end
  end
end
