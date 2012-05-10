@class SDSafariDownload;
@interface SDDownloadCell: UITableViewCell {
	SDSafariDownload *_download;
	UIProgressView *_progressView;
	UILabel *_nameLabel;
	UILabel *_statusLabel;
	UILabel *_sizeLabel;
	UILabel *_progressLabel;
	UIImageView *_iconImageView;
}
@property (nonatomic, retain) SDSafariDownload *download;
- (void)updateDisplay;
- (void)updateProgress;
@end

