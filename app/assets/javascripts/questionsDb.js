(function () {
  var allQuestions = [
    {
      question: "When you are assigned a task that is more than you anticipated,\
                 what do you do?",

      options: [
        "You insult the tasker and walk away",
        "You politely refuse to perform the task and leave immediately",
        "Call a workdey personnel and request for advice",
        "You attempt to renegotiate the amount"
      ],

      answer: "You politely refuse to perform the task and leave immediately",
      reason: "In order to ensure that you always give your best, if you find out \
               that an assigned task is more extensive than described, feel free to \
               politely decline. If you are still willing to do the task, \
               communicate this with your client and let them know the new time \
               estimate"
    },

    {
      question: "When you are assigned a task you feel unsafe, \
                 threatened or uncomfortable about",

      options: [
        "You insult the tasker and walk away",
        "You politely refuse to perform the task and leave immediately",
        "Call a workdey personnel and request for advice",
        "You attempt to renegotiate the amount"
      ],

      answer: "You politely refuse to perform the task and leave immediately",
      reason: "If you ever find yourself in an unsafe or uncomfortable environment, \
               remove yourself from the situation as quickly as possible. \
               If necessary, alert the local authorities."
    },

    {
      question: "You have received notifications about two tasks you have been approved to \
                 perform in two opposite locations and with \
                 similar time frames, what do you do?",

      options: [
        "You accept the two tasks as you need the money and would like to risk it",
        "You prioritize by price and pick the one that favors the money the most",
        "You discuss with both taskers and negotiate how a proposed solution \
         can be worked out",
        "You forfeit both tasks and look for another one"
      ],

      answer: "You discuss with both taskers and negotiate how a proposed solution can be \
               worked out",
      reason: "Always communicate with the Client to confirm details and provide other \
               scheduling options"
    },

    {
      question: "You just received the notification for your first task, what is the first \
                 thing to do?",

      options: [
        "You dance shakiti bobo and call your village members that you just got a new job",
        "You read all the details of the job and follow through with a response to the tasker \
         via the app",
         "Ignore the invitation because you are not interested in the job",
         "Get the tasker’s details and call him for more information"
      ],

      answer: "You read all the details of the job and follow through with a response to the \
               tasker via the app",
      reason: "You should read all the details and confirm with the client and clarify \
               all the details as soon as possible as some specific tasks are \
               time bound. Never accept a task without fully understanding the details \
               of the tasks."
    },

    {
      question: "When calculating the total cost of the job, the additional expenses section \
                 should be used for",

      options: [
        "Extra expenses the client has agreed to pay for",
        "personal expenses such as transportation cost, fuel money",
        "money for recharge card, subscription, bae’s shopping expenses, etc",
        "anything you personally feel the client should pay for"
      ],

      answer: "Extra expenses the client has agreed to pay for",
      reason: "The only time you enter something in the reimbursement box is if \
               you and your client has agreed before hand. You should confirm all \
               expenses before accepting the invitation or ask questions about it via \
               the message section in the app. On no condition should you assume you \
               will be reimbursed for anything, adequate clarification should be \
               provided for all extra expenses."
    },

    {
      question: "You show up to a artisan’s house to perform the scheduled task and \
                 no one is answering the door, you receive a message on the app \
                 from the tasker saying he no longer needs the task to be done. \
                 What do you do?",

      options: [
        "Call the artisan repeatedly until he decides to pay you for your effort",
        "Contact Workdey customer care for task cancellation policies",
        "Threaten the Artisan and tell him you want to do the task by force",
        "Beg the Artisan for another task in a bid to collect small change"
      ],

      answer: "Contact Workdey customer care for task cancellation policies",
      reason: "In the light of last minute cancellations, we encourage both \
               tasker’s and artisan’s  to effectively communicate as quickly \
               as possible. However policies are in place to reimburse efforts \
               made by the artisan in scenarios similar to this"
    },

    {
      question: "You have accepted a notification for a task but you find out \
                 you won’t be able to carry it out because of some emergency. \
                 What do you do?",

      options: [
        "Call your friend who is specialized in the field of the said task and inform him \
         about the details of the task",
         "Find someone who can perform the task and outsource it to him",
         "Immediately inform the tasker  and the Workdey Customer Service about the recent \
          developments and apologize for any inconveniences",
         "Don't do anything at all and expect the Tasker to get the hint when he doesn't hear \
          from you"
      ],

      answer: "Immediately inform the tasker  and the Workdey Customer Service about the \
               recent developments and apologize for any inconveniences",
      reason: "Any developments should be immediately communicated to the Workdey Inc, \
               Customer department and appropriate measures should be taken to find \
               another available tasker."
    },

    {
      question: "The Tasker pays the same amount as I receive",

      options: ["True", "False"],

      answer: "False",
      reason: "A certain percentage is deducted from the amount paid by the Tasker \
               for each completed task. The artisan’s money is however calculated \
               and paid to him"
    },

    {
      question: "When a task has been successfully completed, just let the Tasker know, \
                 they’ll pay you in cash",

      options: ["True", "False"],

      answer: "False",
      reason: "Workdey Inc. charges Tasker’s via their credit card and doesn’t collect \
               cash from Taskers. That way, records can be kept to reflect transaction \
               details for both parties"
    },

    {
      question: "You have a dispute or an issue with your Tasker while completing a task. \
                 What should you do?",

      options: [
        "Engage in a strong heated debate with your Tasker",
        "Invoice your client and get paid before they cancel it",
        "Exchange in physical combat with your Tasker, may the best person win",
        "Call a Workdey Inc, Customer care operative for advice"
      ],

      answer: "Call a Workdey Inc, Customer care operative for advice",
      reason: "Effective communication with your client goes a long way to resolve \
               issues and conflicts. Kindly handle every situation with utmost \
               respect and know that Workdey Customer Care is here for you. \
               Contact Member services to resolve a dispute a misunderstanding \
               of any kind"
    },

    {
      question: "You have billed a Tasker, completed the task, marked it in the \
                 application and even affirmed with your Tasker but you didn’t \
                 receive an alert after 24 hours . What should you do?",

      options: [
        "Contact the Tasker to find out where your money is.",
        "Exercise patience as you know payment takes about 5-7 business days \
         to arrive in your account",
         "Immediately contact Customer Care to pay you your money",
         "Return to the location of the task to request your money in person."
      ],

      answer: "Exercise patience as you know payment takes about 5-7 business \
               days to arrive in your account",
      reason: "We shall immediately notify you that your payment is due is and \
               also notify the tasker that the task has been marked as completed. \
               At this point it could take 5 -7 business days for the funds to \
               be credited to your account"
    }
  ];

  if (typeof Firebase !== "undefined") {
    var dbRef = new Firebase("https://torrid-inferno-5507.firebaseio.com/");

    dbRef.set(allQuestions);
  };
}());
