//= require rails-ujs
//= require jquery3
//= require turbolinks
//= require_tree .

// Lock sidebar scroll position on page change
var scrollTop = null;

document.addEventListener('turbolinks:before-render', function() {
  scrollTop = document.querySelector('.sidebar__top').scrollTop;
});

document.addEventListener('turbolinks:render', function() {
  if (scrollTop) {
    document.querySelector('.sidebar__top').scrollTop = scrollTop;
    scrollTop = null;
  }
});

const application = Stimulus.Application.start();

application.register('mailpeek', class extends Stimulus.Controller {
  static get targets() {
    return ['sidebar', 'overlay'];
  }

  connect() {
    this._handleResize = this._handleResize.bind(this);
    this._handleRefresh = this._handleRefresh.bind(this);

    window.addEventListener('resize', this._handleResize);
    window.onfocus = this._handleRefresh;

    // this.interval = setInterval(this._handleRefresh, 2500);
  }

  disconnect() {
    window.removeEventListener('resize', this._handleResize);

    if (this.interval) {
      clearInterval(this.interval);
      this.interval = null;
    }
  }

  _handleRefresh() {
    $.get('/mailpeek/emails.json' + window.location.search, function(data) {
      const dataIds = data.emails.map(function(email) {
        return String(email.id);
      });

      const elementIds = $.map($('.sidebar__email'), function(element) {
        return String($(element).data('id'));
      });

      let refresh = !isEqual(dataIds, elementIds);

      if (!refresh) {
        data.emails.forEach(function(email) {
          const element = $('.sidebar__email[data-id="' + email.id + '"]');

          if (email.read && element.hasClass('sidebar__unread') ||
              !email.read && element.hasClass('sidebar__read')) {
            refresh = true;
          }
        });
      }

      if (refresh) {
        Turbolinks.visit(window.location.toString(), { action: 'replace' });
      }
    });
  }

  _handleResize() {
    this.sidebarTarget.classList.remove('sidebar_open');
    this.overlayTarget.classList.remove('overlay_open');
  }

  toggleSidebar() {
    this.sidebarTarget.classList.toggle('sidebar_open');
    this.overlayTarget.classList.toggle('overlay_open');
  }
});

application.register('email', class extends Stimulus.Controller {
  static get targets() {
    return [
      'attachments', 'text', 'html', 'tabHtml', 'tabText', 'tabAttachments'
    ]
  }

  connect() {
    if (this.tabHtmlTarget &&
        !this.tabHtmlTarget.classList.contains('hidden')) {
      this.showHtml();
    } else if (this.tabTextTarget &&
               !this.tabTextTarget.classList.contains('hidden')) {
      this.showText();
    }
  }

  showAttachments() {
    this.tabAttachmentsTarget.children[0].classList.add('bg-white');
    this.tabAttachmentsTarget.children[0]
      .classList.remove('border-transparent');
    this.attachmentsTarget.classList.remove('hidden');

    this.tabHtmlTarget.children[0].classList.remove('bg-white');
    this.tabHtmlTarget.children[0].classList.add('border-transparent');
    this.htmlTarget.classList.add('hidden');

    this.tabTextTarget.children[0].classList.remove('bg-white');
    this.tabTextTarget.children[0].classList.add('border-transparent');
    this.textTarget.classList.add('hidden');

    return false;
  }

  showHtml() {
    this.tabAttachmentsTarget.children[0].classList.remove('bg-white');
    this.tabAttachmentsTarget.children[0].classList.add('border-transparent');
    this.attachmentsTarget.classList.add('hidden');

    this.tabHtmlTarget.children[0].classList.add('bg-white');
    this.tabHtmlTarget.children[0].classList.remove('border-transparent');
    this.htmlTarget.classList.remove('hidden');

    this.tabTextTarget.children[0].classList.remove('bg-white');
    this.tabTextTarget.children[0].classList.add('border-transparent');
    this.textTarget.classList.add('hidden');

    return false;
  }

  showText() {
    this.tabAttachmentsTarget.children[0].classList.remove('bg-white');
    this.tabAttachmentsTarget.children[0].classList.add('border-transparent');
    this.attachmentsTarget.classList.add('hidden');

    this.tabHtmlTarget.children[0].classList.remove('bg-white');
    this.tabHtmlTarget.children[0].classList.add('border-transparent');
    this.htmlTarget.classList.add('hidden');

    this.tabTextTarget.children[0].classList.add('bg-white');
    this.tabTextTarget.children[0].classList.remove('border-transparent');
    this.textTarget.classList.remove('hidden');

    return false;
  }
});
