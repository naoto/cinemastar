module Cinemastar
  class Page

    def initialize(page, option = {})
      @page = page.to_i
      @length = option[:length] || 32
    end

    def range
      (now * @length)...((now + 1) * @length)
    end

    def paginate
      (paginate_start...paginate_end).each do |page|
        yield page
      end
    end

    def eq(page)
      @page == page + 1
    end

    def prev
      @page - 1
    end

    def next
      @page + 1
    end

    def last
      100
    end

    def paginate_end
      paginate_start + 5
    end

    def paginate_start
      if @page > 3
        @page - 3
      else 
        0
      end
    end

    def now
      @page - 1
    end
  end
end
