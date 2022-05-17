import pandas as pd
import numpy as np
import networkx as nx

from nltk.cluster.util import cosine_distance

class TextSummarization:

    def __init__(self):
        pass

    def sentence_similarity(self, sent1, sent2, stopwords=None):
        if stopwords is None:
            stopwords = []
    
        sent1 = [w.lower() for w in sent1]
        sent2 = [w.lower() for w in sent2]
    
        all_words = list(set(sent1 + sent2))
    
        vector1 = [0] * len(all_words)
        vector2 = [0] * len(all_words)
    
        # build the vector for the first sentence
        for w in sent1:
            if w in stopwords:
                continue
            vector1[all_words.index(w)] += 1
    
        # build the vector for the second sentence
        for w in sent2:
            if w in stopwords:
                continue
            vector2[all_words.index(w)] += 1
    
        return 1 - cosine_distance(vector1, vector2)

    # build a similarity matrix
    def build_similarity_matrix(self, sentences, stop_words):
        
        similarity_matrix = np.zeros((len(sentences), len(sentences)))
    
        for idx1 in range(len(sentences)):
            for idx2 in range(len(sentences)):
                if idx1 == idx2: #ignore if both are same sentences
                    continue 
                similarity_matrix[idx1][idx2] = self.sentence_similarity(sentences[idx1], sentences[idx2], stop_words)

        return similarity_matrix

    # generate summary
    def generate_summary(self, sentences, top_n=5):
        
        stop_words = ['i', 'me', 'my', 'myself', 'we', 'our', 'ours', 'ourselves', 'you', "you're", "you've", "you'll", "you'd", 'your', 'yours', 'yourself', 'yourselves', 'he', 'him', 'his', 'himself', 'she', "she's", 'her', 'hers', 'herself', 'it', "it's", 'its', 'itself', 'they', 'them', 'their', 'theirs', 'themselves', 'what', 'which', 'who', 'whom', 'this', 'that', "that'll", 'these', 'those', 'am', 'is', 'are', 'was', 'were', 'be', 'been', 'being', 'have', 'has', 'had', 'having', 'do', 'does', 'did', 'doing', 'a', 'an', 'the', 'and', 'but', 'if', 'or', 'because', 'as', 'until', 'while', 'of', 'at', 'by', 'for', 'with', 'about', 'against', 'between', 'into', 'through', 'during', 'before', 'after', 'above', 'below', 'to', 'from', 'up', 'down', 'in', 'out', 'on', 'off', 'over', 'under', 'again', 'further', 'then', 'once', 'here', 'there', 'when', 'where', 'why', 'how', 'all', 'any', 'both', 'each', 'few', 'more', 'most', 'other', 'some', 'such', 'no', 'nor', 'not', 'only', 'own', 'same', 'so', 'than', 'too', 'very', 's', 't', 'can', 'will', 'just', 'don', "don't", 'should', "should've", 'now', 'd', 'll', 'm', 'o', 're', 've', 'y', 'ain', 'aren', "aren't", 'couldn', "couldn't", 'didn', "didn't", 'doesn', "doesn't", 'hadn', "hadn't", 'hasn', "hasn't", 'haven', "haven't", 'isn', "isn't", 'ma', 'mightn', "mightn't", 'mustn', "mustn't", 'needn', "needn't", 'shan', "shan't", 'shouldn', "shouldn't", 'wasn', "wasn't", 'weren', "weren't", 'won', "won't", 'wouldn', "wouldn't"]

        summarize_text = []

        # generate similary martix across sentences
        sentence_similarity_martix = self.build_similarity_matrix(sentences, stop_words)

        # rank sentences in similarity martix
        sentence_similarity_graph = nx.from_numpy_array(sentence_similarity_martix)
        scores = nx.pagerank(sentence_similarity_graph)

        # sort the rank and pick top sentences
        ranked_sentence = sorted(((scores[i],s) for i,s in enumerate(sentences)), reverse=True) 

        for i in range(top_n):
            summarize_text.append("".join(ranked_sentence[i][1].replace("\n", "").strip()))

        return summarize_text


if __name__ == "__main__":

    ts = TextSummarization()
    
    # sentences = ['hi everyone! this room will be used to discuss about the progress of zipplefy thus far\n', 'can you give us an update on the progress for the upcoming zipplefy launch?\n', 'Hello , thanks for creating this group.\n', 'Sure , I have been working together with to get the frontend done.\n\n\n', 'I have also successfully converted Zipplefy from a subscription model to an on-demand model.\n', 'Are we on time for the Google ads cycle 3 campaign this Friday?\n', 'Thus far what is remaining is the completion of the newly designed user guide and testing of the system for any bugs.\n', 'Yes, we are still on time for cycle 3 this Friday.\n', 'nice nice\n', 'Ok, will Ben be ready with the documentation?\n', 'Ben has already passed me the latest changes to the user guide', 'At the moment I am working on redesigning it.\n', 'was there any issues with the stripe integration that ive done?\n', 'From my own testings, none that I have came across so far.\n', '\n', '\n', 'the image cannot see leh\n', 'https://www.canva.com/design/DAFARzY8Xk0/-WLNudn8V55z2emO2Mz_MQ/view?utm_content=DAFARzY8Xk0utm_campaign=designshareutm_medium=linkutm_source=publishsharelink\n', 'i think you can share this through our shared drive\n', 'Canva\n', 'first time seeing this start guide, looks great!\n', 'Awesome :D\n', 'We also should be planning for the Vietnam trip\n', 'yep, but lets take that conversation outside of here unless its zipplefy related\n', 'Alright, not an issue.\n']

    sentences = ['This conversation is about Design for this Deal\n', 'The Hans Zimmer produced soundtrack for the 25th installment in the James Bond film franchise, No Time To Die', 'The soundtrack will include Billie Eilishs electrifying title track No Time To Die, co-written (with brother Finneas OConnell) and performed by Eilish', 'Joining Zimmer on scoring the soundtrack is Johnny Marr, who is also the featured guitarist on the album, with additional music by composer and score producer Steve Mazzaro.\n', 'test\n', 'Another message\n', 'One more test message\n', 'One more test message\n', 'Yesterday, I created a simple, useless chat app to study the asynchronous bidirectional connection with PHP.\n\nYou can use it here, and get the source code here (I dont understand enough what it means to disclose the server-side script', 'I wanna show the beginners an example with SSE and believe theres no vuln and no one wouldnt do something bad :))\n\nAt first, I wanted to learn WebRTC and coded, but the code didnt work because of the hard restriction of my shared server', 'So, I tried some techs, and I found the SSE works properly.\n', 'test\n', 'If the array size is small , the server side can get the querystring', 'But if the array size is big', '(maybe over thousands of characters), the server cant get the querystring', 'Is it possible to use POST method in new EventSource(...) to to pass the json array to server that can avoid the querystring length limitation?\n', 'Test today\n', 'Anoter test\n', 'A test on Microsoft Edge\n', 'Below is an example of a single media object', 'Only two classes are requiredthe wrapping .media and the .media-body around your content', 'Optional padding and margin can be controlled through spacing utilities.\n', 'Across this new divide\n', 'Standing on the frontline when the bombs start to fall', 'Heaven is jealous of our love, angels are crying from up above', 'Cant replace you with a million rings', 'Boy, when youre with me Ill give you a taste', 'Theres no going back', 'Before you met me I was alright but things were kinda heavy', 'Heavy is the head that wears the crown.\n', 'One test today\n', 'one of the issues is that when a new conversation is added, we do not know whether there are any other new conversations before this added by another person\n', '- each time a new conversation is added, call check conversation\n- hidden field of latest message ID?\n- ajax function that calls check conversation and loads latest messages without refreshing\n', 'Conveying meaning to assistive technologies\nUsing color to add meaning only provides a visual indication, which will not be conveyed to users of assistive technologies  such as screen readers', 'Ensure that information denoted by the color is either obvious from the content itself (e.g', 'the visible text), or is included through alternative means, such as additional text hidden with the .sr-only class.\n', 'another test\n', 'One step at a time\n', 'Yes you are right\n', 'Note that depending on how they are used, badges may be confusing for users of screen readers and similar assistive technologies', 'While the styling of badges provides a visual cue as to their purpose, these users will simply be presented with the content of the badge', 'Depending on the specific situation, these badges may seem like random additional words or numbers at the end of a sentence, link, or button.\n\nUnless the context is clear (as with the Notifications example, where it is understood that the 4 is the number of notifications), consider including additional context with a visually hidden piece of additional text.\n', 'Test\n', 'Ok we have another test here\n', 'In the code above:\n\nWe placed our Ajax request inside a custom function called send', 
'You can name this as something else if you wish.\nInside the success function of our Ajax request, we use the setTimeout method', 'Here, we specify that we want to send another request 10 seconds after the current request has been successfully completed', 'This means that the script we are sending the request to should only receive 1 request every 10 seconds at most.\n', 'This solution relies on the first call to be a success', 'If at any point in time your code doesnt succeed (perhaps there was a server hiccup?), your polling will stop until a page refresh.\n\nYou could use setInterval to call that method on a defined interval, which avoids this problem:\n', 'Is that so?\n', 'With both solutions, your server will be handling a lot of requests it might not need to', 'You can use a library like PollJS (shameless self plug) to add increasing delays, which will increase performance and decrease bandwidth:\n', 'Testing again\n', 
'Bootstraps modal class exposes a few events for hooking into modal functionality', 'All modal events are fired at the modal itself (i.e', 'at the div class=modal).\n', 'Ok got it', 'Will be attending\n', 'Thank you', 'Please remember to bring your laptop.\n', 'Yes I will\n', 'Thanks\n', 'Welcome', 'Do you need me to prepare the powerpoint as well?\n', 'No need', 'You can get from Cath.\n', 'Got it\n']

    summary = ts.generate_summary(sentences, 3)
    print(summary)