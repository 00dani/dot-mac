(function() {
	const titleSpecials = /([\[\]\\*_])/g;
	const urlSpecials = /([()\\])/g;
	const mdEscape = (str, specials) => str.replace(specials, '\\$1');
	const app = Application('Hookmark');
	let mark = app.bookmarkFromActiveWindow();
	if (typeof mark === 'string') {
		delay(1);
		mark = app.bookmarkByRequestHandle(mark);
	}
	return `[${mdEscape(mark.name(), titleSpecials)}](${mdEscape(mark.address(), urlSpecials)})`;
})();
