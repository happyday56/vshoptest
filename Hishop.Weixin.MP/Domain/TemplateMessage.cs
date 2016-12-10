﻿using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;


namespace Hishop.Weixin.MP.Domain
{
    public class TemplateMessage
    {

        public TemplateMessage()
        {
            this.Topcolor = "#00FF00";
        }

        public IEnumerable<MessagePart> Data { get; set; }

        public string TemplateId { get; set; }

        public string Topcolor { get; set; }

        public string Touser { get; set; }

        public string Url { get; set; }

        public class MessagePart
        {
            public MessagePart()
            {
                this.Color = "#000099";
            }

            public string Color { get; set; }

            public string Name { get; set; }

            public string Value { get; set; }
        }
    }
}

