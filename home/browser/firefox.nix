{username, ...}:
{
	programs.firefox = {
		enable = true;
		profiles.username = {
			bookmarks = [
				{
					name = "YouTube";
					tags = [ "youtube" ];
					keyword = "wiki";
					url = "https://www.youtube.com/";
				}
			];
		};
	};
}
