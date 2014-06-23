class Notifier < ActionMailer::Base
  default from: "noreply@xibbar.net"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.article.subject
  #
  def article(url, to)
    @url = url

    mail subject: "kijibato からのお知らせ", to: to
  end
  def login_url(url, to)
    @url = url
    mail subject: "kijibato からのお知らせ", to: to
  end
end
