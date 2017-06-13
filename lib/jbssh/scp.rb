module Jbssh
  class SCP
    def self.upload(ip, user, local_path, remote_path)
      progressbar = ProgressBar.create(title: "#{name}: TRANSFER ===>", length: 100, format: "%t |%B| %P%%",:progress_mark  => '#')
      Net::SCP.upload!(ip, user, local_path, remote_path) do |ch, name, sent, total|
        progressbar.progress = sent.fdiv(total) * 100
      end

      # 100.0
      progressbar.progress
    end

    def self.download(ip, user, remote_path, local_path)
      # remote_path = "/home/vagrant/output/#{remote_file}"
      # node = self.encoders[name.to_sym]
      progressbar = ProgressBar.create(title: "#{name}: TRANSFER ===>", length: 100, format: "%t |%B| %P%%", :progress_mark  => '#')

      Net::SCP.download!(ip, user, remote_path, local_path) do |ch, name, sent, total|
        progressbar.progress = sent.fdiv(total) * 100
      end

      # 100.0
      progressbar.progress
    end
  end
end
