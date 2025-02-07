import consumer from "channels/consumer"

$(function() {
  const book_id = $("#review-book-list").data("book-id")

  consumer.subscriptions.create({ channel: "ReviewChannel", book_id}, {

    // Connect to channel
    connected() {
      // console.log(`Connected to ReviewChannel for book`);
    },

    // Display data ActionCable
    received(data) {
      console.log(data)
      $("#review-book-list").append(`<p>${data.review}</p>`);
    }
  });

  // Xử lý form submit review
  $("#review-form").on("submit", function(event) {
    event.preventDefault();

    const reviewContent = $(this).find("#input-review").val();

    $.post($(this).attr("action"), { content: reviewContent }, function(response) {
      $("#input-review").val("").focus();
      $("#button-submit-review").prop("disabled", false);
    })
  })
})
