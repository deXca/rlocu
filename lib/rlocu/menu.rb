module Rlocu
  class Menu
    attr_accessor :name
    attr_reader :sections

    def initialize(meta_menu)
      @name = meta_menu['menu_name']
      self.sections = meta_menu['sections']
    end

    def sections=(meta_sections)
      @sections = []
      meta_sections.each {|h| @sections << Section.new(h)}
    end

  end

  class Section
    attr_accessor :name
    attr_reader :subsections

    def initialize(meta_section)
      @name = meta_section['section_name']
      self.subsections = meta_section['subsections']
    end

    def subsections=(meta_subsections)
      @subsections = []
      meta_subsections.each {|h| @subsections << Subsection.new(h)}
    end

  end

  class Subsection
    attr_accessor :name
    attr_reader :contents

    def initialize(meta_subsection)
      @name = meta_subsection['subsection_name']
      self.contents = meta_subsection['contents']
    end

    def contents=(meta_contents)
      @contents = []
      meta_contents.each do |h|
        #TODO: raise error if type is different
        @contents << case h['type']
          when 'SECTION_TEXT'
            SectionText.new(h)
          when 'ITEM'
            MenuItem.new(h)
        end  
      end
    end

  end

  class SectionText
    attr_accessor :type, :text

    def initialize(meta_section_text)
      @type = meta_section_text['type']
      @text = meta_section_text['text']
    end

    def to_s
      @text
    end
  
  end

# create a to_s for each that can be over-ridden by the user
  class MenuItem
    attr_accessor :type, :name, :description, :price
    attr_reader :option_groups

    def initialize(meta_menu_item)
      @type = meta_menu_item['type']
      @name = meta_menu_item['name']
      @description = meta_menu_item['description']
      @price = meta_menu_item['price']
      self.option_groups = meta_menu_item['option_groups'] 
    end

    def option_groups=(meta_option_groups)
      @option_groups = []
      meta_option_groups.each { |h| @option_groups << OptionGroup.new(h) } if meta_option_groups
    end

  end

  class OptionGroup
    attr_accessor :type, :text
    attr_reader :options

    def initialize(meta_option_group)
      @type = meta_option_group['type']
      @text = meta_option_group['text']
      self.options = meta_option_group['options'] 
    end

    def options=(meta_options)
      @options = []
      meta_options.each {|h| @options << Option.new(h) } if meta_options
    end


  end

  class Option
    attr_accessor :name
    attr_writer :price

    def initialize(meta_option)
      @name = meta_option['name']
      @price = meta_option['price']
    end

    def price
      # price can be relative indicated by a + in the price
      # not currently doing anything w it 
      @price
    end

    def to_s
      "#{name} #{price}"
    end

  end
end