function fetchBooks(keyword) {
    $.ajax({
        url: "/ajax_search_books",
        method: "GET",
        data: { search: keyword },
        success: function (data) {
            console.log(data)
            // Render partial (list_book) of books table
            $(".list-book-content").html(data.partial)
        }
    })
}

$(function () {
    const searchInput = $("#search-input")
    searchInput.on("keyup", function () {
		const keyword = searchInput.val();
		fetchBooks(keyword);
	});
})