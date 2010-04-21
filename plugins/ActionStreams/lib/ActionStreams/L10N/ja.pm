# Movable Type (r) (C) 2001-2008 Six Apart, Ltd. All Rights Reserved.
# This code cannot be redistributed without permission from www.sixapart.com.
# For more information, consult your Movable Type license.
#
# $Id: $

package ActionStreams::L10N::ja;

use strict;
use base 'ActionStreams::L10N::en_us';
use vars qw( %Lexicon );
%Lexicon = (

## plugins/ActionStreams/blog_tmpl/actions.mtml
    'Recent Actions' => '最近のアクション',

## plugins/ActionStreams/blog_tmpl/banner_footer.mtml
    '_POWERED_BY' => 'Powered by <a href="http://www.sixapart.jp/movabletype/"><$MTProductName$></a>',
    'This blog is licensed under a <a href="[_1]">Creative Commons License</a>.' => 'このブログは<a href="[_1]">クリエイティブ・コモンズ</a>でライセンスされています。',

## plugins/ActionStreams/blog_tmpl/banner_header.mtml

## plugins/ActionStreams/blog_tmpl/elsewhere.mtml
    'Find [_1] Elsewhere' => '[_1]の利用サービス',

## plugins/ActionStreams/blog_tmpl/feed_recent.mtml

## plugins/ActionStreams/blog_tmpl/html_head.mtml

## plugins/ActionStreams/blog_tmpl/main_index.mtml
    'HTML Head' => 'HTMLヘッダー',
    'Banner Header' => 'バナーヘッダー',
    'Sidebar' => 'サイドバー',
    'Banner Footer' => 'バナーフッター',

## plugins/ActionStreams/blog_tmpl/sidebar.mtml
    '2-column layout - Sidebar' => '2カラムのサイドバー',

## plugins/ActionStreams/blog_tmpl/styles.mtml

## plugins/ActionStreams/config.yaml
    'Manages authors\' accounts and actions on sites elsewhere around the web' => 'ユーザーがウェブで利用しているサービスのアカウントとアクションを管理します',
    'Action Streams Theme.' => 'アクションストリームテーマ',
    'Are you sure you want to hide EVERY event in EVERY action stream?' => '全アクションストリームの全イベントを非表示にしてよろしいですか?',
    'Are you sure you want to show EVERY event in EVERY action stream?' => '全アクションストリームの全イベントを表示にしてよろしいですか?',
    'Deleted events that are still available from the remote service will be added back in the next scan. Only events that are no longer available from your profile will remain deleted. Are you sure you want to delete the selected event(s)?' => 'イベントを削除してもリモートサービスは有効となっています。次の更新調査時に追加されます。ユーザプロフィールからイベントを無効にすれば削除されます。選択したイベントを削除してよろしいですか?',
    'Hide All' => '全て非表示',
    'Show All' => '全て表示',
    'Delete' => '削除',
    'Poll for new events' => '新しいイベントの獲得',
    'Expire old events' => '古いイベントの削除',
    'Update Events' => 'イベントの更新',
    'Recent Actions' => '最近のアクション',
    'Action Stream' => 'アクションストリーム',
    'Main Index (Recent Actions)' => 'メインインデックス(最近のアクション)',
    'Stylesheet' => 'スタイルシート',
    'Feed - Recent Activity' => 'フィード - 最近のアクティビティー',
    'HTML Head' => 'HTMLヘッダー',
    'Banner Header' => 'バナーヘッダー',
    'Banner Footer' => 'バナーフッター',
    'Sidebar' => 'サイドバー',
    'Find Authors Elsewhere' => 'ユーザーの利用サービス',
    '2-column layout - Sidebar' => '2カラムのサイドバー',
    'Action Streams Theme' => 'アクションストリームテーマ',
    'Enabling default action streams for selected profiles...' => '選択したプロフィールの既存アクションストリームを有効にしています...',

## plugins/ActionStreams/doc/example_templates/indexes/action-stream-archive.mtml

## plugins/ActionStreams/doc/example_templates/indexes/action-stream-index.mtml

## plugins/ActionStreams/doc/example_templates/widgets/author-action-stream.mtml

## plugins/ActionStreams/doc/example_templates/widgets/author-find-me-elsewhere.mtml

## plugins/ActionStreams/extlib/HTML/AsSubs.pm

## plugins/ActionStreams/extlib/HTML/Element.pm

## plugins/ActionStreams/extlib/HTML/Element/traverse.pm

## plugins/ActionStreams/extlib/HTML/Parse.pm

## plugins/ActionStreams/extlib/HTML/Selector/XPath.pm

## plugins/ActionStreams/extlib/HTML/Tree.pm

## plugins/ActionStreams/extlib/HTML/TreeBuilder.pm

## plugins/ActionStreams/extlib/HTML/TreeBuilder/XPath.pm

## plugins/ActionStreams/extlib/HTTP/Response/Encoding.pm

## plugins/ActionStreams/extlib/Web/Scraper.pm

## plugins/ActionStreams/extlib/Web/Scraper/Filter.pm

## plugins/ActionStreams/extlib/XML/XPathEngine.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/Boolean.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/Expr.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/Function.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/Literal.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/LocationPath.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/NodeSet.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/Number.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/Root.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/Step.pm

## plugins/ActionStreams/extlib/XML/XPathEngine/Variable.pm

## plugins/ActionStreams/ja.pm

## plugins/ActionStreams/lib/ActionStreams/Event.pm
    '[_1] updating [_2] events for [_3]' => '[_3]の[_2]イベントを更新しています: [_1]',
    'Error updating events for [_1]\'s [_2] stream (type [_3] ident [_4]): [_5]' => '[_1]の[_2]ストリーム([_3]タイプの[_4])の更新に失敗しました: [_5]',
    'Could not load class [_1] for stream [_2] [_3]: [_4]' => '[_2]([_3])ストリームの[_1]クラスのロードができません: [_4]',
    'No URL to fetch for [_1] results' => '[_1]の更新情報のURLが設定されていません',
    'Could not fetch [_1]: [_2]' => '[_1]の更新に失敗しました: [_2]',
    'Aborted fetching [_1]: [_2]' => '[_1]の更新を中止しました: [_2]',

## plugins/ActionStreams/lib/ActionStreams/Event/BlurstAchievements.pm

## plugins/ActionStreams/lib/ActionStreams/Event/Identica.pm

## plugins/ActionStreams/lib/ActionStreams/Event/OneupPlaying.pm

## plugins/ActionStreams/lib/ActionStreams/Event/Steam.pm

## plugins/ActionStreams/lib/ActionStreams/Event/Twitter.pm

## plugins/ActionStreams/lib/ActionStreams/Event/TwitterFavorite.pm

## plugins/ActionStreams/lib/ActionStreams/Event/TwitterTweet.pm

## plugins/ActionStreams/lib/ActionStreams/Event/Vox.pm

## plugins/ActionStreams/lib/ActionStreams/Event/Website.pm

## plugins/ActionStreams/lib/ActionStreams/Event/XboxGamerscore.pm

## plugins/ActionStreams/lib/ActionStreams/Fix.pm

## plugins/ActionStreams/lib/ActionStreams/Init.pm

## plugins/ActionStreams/lib/ActionStreams/L10N.pm

## plugins/ActionStreams/lib/ActionStreams/L10N/de.pm

## plugins/ActionStreams/lib/ActionStreams/L10N/en_us.pm

## plugins/ActionStreams/lib/ActionStreams/L10N/es.pm

## plugins/ActionStreams/lib/ActionStreams/L10N/fr.pm

## plugins/ActionStreams/lib/ActionStreams/L10N/ja.pm

## plugins/ActionStreams/lib/ActionStreams/L10N/nl.pm

## plugins/ActionStreams/lib/ActionStreams/Plugin.pm
    'Other Profiles' => '利用サービス',
    'Action Stream' => 'アクションストリーム',
    'Profiles' => 'プロフィール',
    'Actions from the service [_1]' => 'サービス([_1])のアクション',
    'Actions that are shown' => '表示アクション',
    'Actions that are hidden' => '非表示アクション',
    'No such event [_1]' => '[_1]イベントはありません',
    '[_1] Profile' => '[_1]',
    'Invalid request.' => '不正な要求です。',
    '[_1] action streams events are expired' => '[_1]個のアクションデータが削除されました',

## plugins/ActionStreams/lib/ActionStreams/Scraper.pm

## plugins/ActionStreams/lib/ActionStreams/Tags.pm
    'No user [_1]' => 'ユーザー([_1])は見つかりません',

## plugins/ActionStreams/lib/ActionStreams/Upgrade.pm
    'Updating classification of [_1] [_2] actions...' => '[_1]の[_2]アクションの分類を更新中...',
    'Renaming "[_1]" data of [_2] [_3] actions...' => '[_2]の[_3]アクションデータを"[_1]"に変更中...',

## plugins/ActionStreams/lib/ActionStreams/UserAgent/Adapter.pm

## plugins/ActionStreams/lib/ActionStreams/UserAgent/Cache.pm

## plugins/ActionStreams/lib/ActionStreams/Worker.pm
    'No such author with ID [_1]' => 'ユーザーID([_1])は見つかりません。',

## plugins/ActionStreams/services.yaml
    '1up.com' => '1up.com',
    '43Things' => '43Things',
    'AIM' => 'AIM',
    'Screen name' => '表示名',
    'backtype' => 'backtype',
    'Bebo' => 'Bebo',
    'Blurst' => 'Blurst',
    'Username' => 'ユーザー名',
    'Catster' => 'Catster',
    'COLOURlovers' => 'COLOURlovers',
    'Cork\'\'d\'' => 'Cork\'\'d\'',
    'Delicious' => 'Delicious',
    'Destructoid' => 'Destructoid',
    'Digg' => 'Digg',
    'Dodgeball' => 'Dodgeball',
    'Dogster' => 'Dogster',
    'Dopplr' => 'Dopplr',
    'Facebook' => 'Facebook',
    'User ID' => 'ユーザーID',
    'FFFFOUND!' => 'FFFFOUND!',
    'Flickr' => 'Flickr',
    'Enter your Flickr user ID that has a "@" in it. Your Flickr user ID is NOT the username in the URL of your photo stream.' => '"@"が含まれるFlickrのユーザーIDを入力してください。フォトストリームのURLに含まれるユーザーネームとは異なります。',
    'FriendFeed' => 'FriendFeed',
    'Gametap' => 'Gametap',
    'Goodreads' => 'Goodreads',
    'Google Reader' => 'Google Reader',
    'Sharing ID' => '共有ID',
    'Hi5' => 'Hi5',
    'IconBuffet' => 'IconBuffet',
    'ICQ' => 'ICQ',
    'UIN' => 'UIN',
    'Identi.ca' => 'Identi.ca',
    'Iminta' => 'Iminta',
    'Instructables' => 'Instructables',
    'iStockphoto' => 'iStockPhoto', # Translate - Case
    'IUseThis' => 'IUseThis',
    'iwatchthis' => 'iwatchthis',
    'Jabber' => 'Jabber',
    'Jabber ID' => 'Jabber ID',
    'Jaiku' => 'Jaiku',
    'Kongregate' => 'Kongregate',
    'Last.fm' => 'Last.fm',
    'LinkedIn' => 'LinkedIn',
    'Profile URL' => 'プロフィールID',
    'LiveJournal' => 'LiveJournal',
    'Ma.gnolia' => 'Ma.gnolia',
    'MetaFilter' => 'MetaFilter',
    'User Number' => 'ユーザー番号',
    'MOG' => 'MOG',
    'MSN Messenger\'' => 'MSN Messenger\'',
    'Multiply' => 'Multiply',
    'MySpace' => 'MySpace',
    'Netflix' => 'Netflix',
    'Netflix RSS ID' => 'Netflix RSS ID',
    'To find your Netflix RSS ID, click "RSS" at the bottom of any page on the Netflix site, then copy and paste in your "Queue" link.' => 'Netflix RSS IDはNetflixサイトのどこかのページで"RSS"をクリックとあります。それから"Queue"リンクをコピーして貼り付けてください。',
    'Netvibes' => 'Netvibes',
    'Newsvine' => 'Newsvine',
    'Ning' => 'Ning',
    'Social Network URL' => 'ソーシャルネットワークURL',
    'New York Times (TimesPeople)' => 'New York Times (TimePeople)',
    'Activity URL' => 'プロフィールページのURL',
    'Ohloh' => 'Ohloh',
    'Orkut' => 'Orkut',
    'Pandora' => 'Pandora',
    'Picasa Web Albums' => 'Picasa Web Albums',
    'p0p' => 'p0p',
    'Pownce' => 'Pownce',
    'Reddit' => 'Reddit',
    'Skype' => 'Skype',
    'SlideShare' => 'SlideShare',
    'Smugmug' => 'Smugmug',
    'SonicLiving' => 'SonicLiving',
    'Steam' => 'Steam',
    'StumbleUpon' => 'StumbleUpon',
    'Tabblo' => 'Tabblo',
    'Technorati' => 'Techonrati',
    'Tribe' => 'Tribe',
    'Tumblr' => 'Tumblr',
    'URL' => 'URL',
    'Twitter' => 'Twitter',
    'TypePad' => 'TypePad',
    'Uncrate' => 'Uncrate',
    'Upcoming' => 'Upcoming',
    'Viddler' => 'Viddler',
    'Vimeo' => 'Vimeo',
    'Virb' => 'Virb',
    'Vox' => 'Vox',
    'Vox name' => 'Voxユーザー名',
    'Website' => 'Website',
    'Wists' => 'Wists',
    'Xbox Live\'' => 'Xbox Live\'',
    'Gamertag' => 'ゲーマータグ',
    'Yahoo! Messenger\'' => 'Yahoo! Messenger\'',
    'Yelp' => 'Yelp',
    'YouTube' => 'YouTube',
    'Zooomr' => 'Zooomr',

## plugins/ActionStreams/streams.yaml
    'Currently Playing' => '現在プレー中',
    'The games in your collection you\'re currently playing' => 'コレクションの中で現在プレーしているゲーム',
    'Comments' => 'コメント',
    'Comments you have made on the web' => 'ウェブで投稿したコメント',
    'Achievements' => '実績',
    'Achievements earned in Blurst games' => 'Blurstゲームの実績',
    'Colors' => 'カラー',
    'Colors you saved' => '保存したカラー',
    'Palettes' => 'パレット',
    'Palettes you saved' => '保存したパレット',
    'Patterns' => 'パターン',
    'Patterns you saved' => '保存したパターン',
    'Favorite Palettes' => 'お気に入りのパレット',
    'Palettes you saved as favorites' => '保存したお気に入りのパレット',
    'Reviews' => 'レビュー',
    'Your wine reviews' => 'ワインレビュー',
    'Cellar' => 'セラー',
    'Wines you own' => '所有しているワイン',
    'Shopping List' => '買物リスト',
    'Wines you want to buy' => '買いたいワイン',
    'Links' => 'リンク',
    'Your public links' => '公開リンク',
    'Dugg' => 'ダグ',
    'Links you dugg' => 'ダグしたリンク',
    'Submissions' => '承認',
    'Links you submitted' => '承認したリンク',
    'Found' => '見つけた',
    'Photos you found' => '見つけた写真',
    'Favorites' => 'お気に入り',
    'Photos you marked as favorites' => 'お気に入りにした写真',
    'Photos' => '写真',
    'Photos you posted' => '保存した写真',
    'Likes' => 'リンク',
    'Things from your friends that you "like"' => '好みのユーザーの物',
    'Leaderboard scores' => 'リーダーボードスコア',
    'Your high scores in games with leaderboards' => 'リーダーボードのゲームのハイスコア',
    'To read' => 'これから読む',
    'Books on your "to-read" shelf' => '本棚のこれから読む本',
    'Reading' => '読んでいる',
    'Books on your "currently-reading" shelf' => '本棚の読んでいる本',
    'Read' => '読む',
    'Books on your "read" shelf' => '本棚の読む本',
    'Shared' => '共有',
    'Your shared items' => '共有アイテム',
    'Deliveries' => '配布',
    'Icon sets you were delivered' => '配布されたアイコンセット',
    'Notices' => '通知',
    'Notices you posted' => '投稿した通知',
    'Intas' => 'Intas',
    'Links you saved' => '保存したリンク',
    'Instructables you saved as favorites' => 'お気に入りにしたInstructables',
    'Photos you posted that were approved' => '承認した投稿した写真',
    'Recent events' => '最近のイベント',
    'Events from your recent events feed' => '最近のイベントフィードのイベント',
    'Apps you use' => '使用アプリ',
    'The applications you saved as ones you use' => '使用するアプリケーション',
    'Videos you saved as watched' => '見たビデオ',
    'Jaikus' => 'Jaikus',
    'Jaikus you posted' => '投稿したJaikus',
    'Games you saved as favorites' => 'お気に入りにしたゲーム',
    'Achievements you won' => '獲得した成果',
    'Tracks' => '曲',
    'Songs you recently listened to (High spam potential!)' => '最近聞いた歌(スパムの可能性あり)',
    'Loved Tracks' => '大好きな曲',
    'Songs you marked as "loved"' => '大好きとマークした歌',
    'Journal Entries' => 'ジャーナル記事',
    'Your recent journal entries' => '最近のジャーナル記事',
    'Events' => 'イベント',
    'The events you said you\'ll be attending' => '参加表明したイベント',
    'Posts' => '記事',
    'Your public posts to your journal' => '公開投稿のジャーナル',
    'Posts you saved as favorites' => 'お気に入りにした投稿',
    'Queue' => '待ちリスト',
    'Movies you added to your rental queue' => 'レンタルリストに入れた映画',
    'Recent Movies' => '最近の映画',
    'Recent Rental Activity' => '最近のレンタル活動',
    'Recommendations' => 'お勧め',
    'Recommendations in your TimesPeople activities' => 'TimesPeopleでのお勧め',
    'Kudos' => 'Kudos',
    'Kudos you have received' => '受け取ったKudos',
    'Favorite Songs' => 'お気に入りの歌',
    'Songs you marked as favorites' => 'お気に入りにした歌',
    'Favorite Artists' => 'お気に入りのアーティスト',
    'Artists you marked as favorites' => 'お気に入りにしたアーティスト',
    'Stations' => 'ステーション',
    'Radio stations you added' => '追加したラジオステーション',
    'List' => 'リスト',
    'Things you put in your list' => 'リストに入れた物',
    'Notes' => 'メモ',
    'Your public notes' => '公開メモ',
    'Comments you posted' => '投稿したコメント',
    'Articles you submitted' => '投稿した記事',
    'Articles you liked (your votes must be public)' => '好きな記事(公開にしています)',
    'Dislikes' => '嫌い',
    'Articles you disliked (your votes must be public)' => '嫌いな記事(公開にしています)',
    'Slideshows you saved as favorites' => 'お気に入りにしたスライドショー',
    'Slideshows' => 'スライドショー',
    'Slideshows you posted' => '投稿したスライドショー',
    'Your achievements for achievement-enabled games' => '成果の出るゲームでの成果',
    'Stuff' => '物',
    'Things you posted' => '投稿した物',
    'Tweets' => 'Tweet',
    'Your public tweets' => '公開tweet',
    'Public tweets you saved as favorites' => 'お気に入りにした公開tweet',
    'Saved' => '保存',
    'Things you saved as favorites' => 'お気に入りにした物',
    'Events you are watching or attending' => '見ているまたは参加しているイベント',
    'Videos' => 'ビデオ',
    'Videos you posted' => '投稿したビデオ',
    'Videos you liked' => 'リンクしたビデオ',
    'Public assets you saved as favorites' => 'お気に入りにした公開アイテム',
    'Your public photos in your Vox library' => 'Voxの公開写真',
    'Your public posts to your Vox' => 'Voxの公開記事',
    'The posts available from the website\'s feed' => 'ウェブサイトのフィードで有効な記事',
    'Wists' => 'Wists',
    'Stuff you saved' => '保存した物',
    'Gamerscore' => 'ゲームスコア',
    'Notes when your gamerscore passes an even number' => 'ゲームスコアが同点をこえた時のメモ',
    'Places you reviewed' => 'レビューした場所',
    'Videos you saved as favorites' => 'お気に入りにしたビデオ',

## plugins/ActionStreams/tmpl/blog_config_template.tmpl
    'Rebuild Indexes' => 'インデックス再構築',
    'If selected, this blog\'s indexes will be rebuilt when new action stream events are discovered.' => '新しいアクションストリームイベントが見つかった時に、ブログのインデックスを再構築する。',
    'Enable rebuilding' => '再構築を有効にする',

## plugins/ActionStreams/tmpl/dialog_add_profile.tmpl
    'Add Profile' => 'プロフィール追加',
    'Your user name or ID is required.' => 'ユーザー名またはIDが必須です。',
    'Add a profile on a social networking or instant messaging service.' => 'ソーシャルネットワーク、またはインスタントメッセージサービスのプロフィールを追加します。',
    'Service' => 'サービス',
    'Select a service where you already have an account.' => 'アカウントをもっているサービスを選択してください。',
    'Username' => 'ユーザー名',
    'Enter your account on the selected service.' => '選択したサービスのアカウントを入力してください。',
    'For example:' => '例: ',
    'Action Streams' => 'アクションストリーム',
    'Select the action streams to collect from the selected service.' => '選択したサービスから集めるアクションストリームをチェックしてください。',
    'No streams are available for this service.' => 'このサービスでは利用できるストリームがありません。',
    'Add Profile (s)' => 'プロフィール追加 (s)',
    'Cancel (x)' => 'キャンセル (x)',
    'Cancel' => 'キャンセル',

## plugins/ActionStreams/tmpl/dialog_edit_profile.tmpl
    'Edit Profile' => 'ユーザー情報の編集',
    'Your user name or ID is required.' => 'ユーザー名またはIDが必須です。',
    'Edit a profile on a social networking or instant messaging service.' => 'SNSやIMサービスなどのプロファイルを編集します。',
    'Service' => 'サービス',
    'Username' => 'ユーザー名',
    'Enter your account on the selected service.' => '選択したサービスのアカウントを入力してください。',
    'For example:' => '例: ',
    'Action Streams' => 'アクションストリーム',
    'Select the action streams to collect from the selected service.' => '選択したサービスから集めるアクションストリームをチェックしてください。',
    'No streams are available for this service.' => 'このサービスでは利用できるストリームがありません。',
    'Save Changes (s)' => '変更を保存 (s)',
    'Save Changes' => '変更を保存',
    'Cancel (x)' => 'キャンセル (x)',
    'Cancel' => 'キャンセル',

## plugins/ActionStreams/tmpl/list_profileevent.tmpl
    'Action Stream for [_1]' => '[_1]のアクションストリーム',
    'User properties' => 'ユーザー属性',
    'The selected events were deleted.' => '選択したイベントは削除されました。',
    'The selected events were hidden.' => '選択したイベントを非表示にしました。',
    'The selected events were shown.' => '選択したイベントを表示にしました。',
    'All action stream events were hidden.' => '全アクションストリームイベントを非表示にしました。',
    'All action stream events were shown.' => '全アクションストリームイベントを表示にしました。',
    'event' => 'イベント',
    'events' => 'イベント',
    'Hide selected events (h)' => '選択したイベントを非表示にする (h)',
    'Hide' => '非表示',
    'Show selected events (s)' => '選択したイベントを表示にする (s)',
    'Show' => '表示',
    'Showing only: [_1]' => '[_1]を表示',
    'Remove filter' => 'フィルタしない',
    'All stream actions' => 'すべてのストリームアクション',
    'change' => '絞り込み',
    'Show only actions where' => 'アクションを表示: ',
    'service' => 'サービス',
    'visibility' => '表示/非表示',
    'is' => 'が',
    'hidden' => '非表示',
    'shown' => '表示',
    'Filter' => 'フィルタ',
    'Cancel' => 'キャンセル',
    'No events could be found.' => 'イベントが見つかりません。',
    'Status' => '更新状態',
    'Event' => 'イベント',
    'Service' => 'サービス',
    'Created' => '作成',
    'View' => '表示',
    'Shown' => '表示',
    'Hidden' => '非表示',
    '_external_link_target' => '_blank',
    'View action link' => 'アクションリンク表示',

## plugins/ActionStreams/tmpl/other_profiles.tmpl
    'Other Profiles for [_1]' => '[_1]のプロフィール',
    'The selected profile was added.' => '選択したプロフィールは追加されました。',
    'The selected profiles were removed.' => '選択したプロフィールは削除されました。',
    'The selected profiles were scanned for updates.' => '選択したプロフィールの更新を調べました。',
    'The changes to the profile have been saved.' => 'プロフィールの変更が保存されました。',
    'User properties' => 'ユーザー属性',
    'Add Profile' => 'プロフィール追加',
    'profile' => 'プロフィール',
    'profiles' => 'プロフィール',
    'Delete selected profiles (x)' => '選択したプロフィール削除(x)',
    'Delete' => '削除',
    'to update' => '更新',
    'Scan now for new actions' => '新しいアクションを調べる',
    'Update Now' => '今すぐ更新する',
    'No profiles were found.' => 'プロフィールが見つかりません。',
    'Service' => 'サービス',
    'Username' => 'ユーザー名',
    'View' => '表示',
    'external_link_target' => '外部リンクターゲット',
    'View Profile' => 'プロフィール表示',

## plugins/ActionStreams/tmpl/sys_config_template.tmpl
    'Expireing Events' => 'イベントデータの削除',
    'If selected, old events data would be removed automatically.' => '古いイベントデータを自動的に削除します。',
    'Enable expiring' => '自動削除を有効にする',
    'Expireing Interval' => '自動削除の間隔',
    'Specify the days to wait for auto expire.' => '自動削除までの日数',
    'days for expireing' => '削除までの日数',

## plugins/ActionStreams/tmpl/widget_recent.mtml
    'Your Recent Actions' => '最近のアクション',
    'blog this' => '記事作成',
    'No actions could be found.' => 'アクションが見つかりません。',

);

1;
