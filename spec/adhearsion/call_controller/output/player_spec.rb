# encoding: utf-8

require 'spec_helper'
require 'ruby_speech'

module Adhearsion
  class CallController
    module Output
      describe Player do
        include CallControllerTestHelpers

        let(:controller) { new_controller }

        subject { Player.new controller }

        describe "#output" do
          let(:content) { RubySpeech::SSML.draw { string "BOO" } }

          it "should execute an output component with the provided SSML content" do
            expect_component_execution Punchblock::Component::Output.new(:ssml => content)
            subject.output content
          end

          it "should allow extra options to be passed to the output component" do
            component = Punchblock::Component::Output.new :ssml => content, :start_paused => true
            expect_component_execution component
            subject.output content, :start_paused => true
          end

          it "yields the component to the block before waiting for it to finish" do
            component = Punchblock::Component::Output.new :ssml => content

            expect(controller).to receive(:execute_component_and_await_completion).once.with(component).and_yield(:foo)

            @foo = nil

            subject.output content do |comp|
              @foo = comp
            end

            expect(@foo).to eq(:foo)
          end

          it "raises a PlaybackError if the component fails to start" do
            expect_component_execution Punchblock::Component::Output.new(:ssml => content), Punchblock::ProtocolError
            expect { subject.output content }.to raise_error(PlaybackError)
          end

          it "raises a Playback Error if the component ends due to an error" do
            expect_component_execution Punchblock::Component::Output.new(:ssml => content), Adhearsion::Error
            expect { subject.output content }.to raise_error(PlaybackError)
          end

          it "raises a Call::Hangup exception if the component ends due to an error" do
            expect_component_execution Punchblock::Component::Output.new(:ssml => content), Call::Hangup
            expect { subject.output content }.to raise_error(Call::Hangup)
          end
        end

        describe "#play_ssml" do
          let(:ssml) { RubySpeech::SSML.draw { string "BOO" } }

          it 'executes an Output with the correct ssml' do
            expect_component_execution Punchblock::Component::Output.new(:ssml => ssml)
            subject.play_ssml ssml
          end
        end

        describe "#play_url" do
          let(:url) { "http://example.com/ex.ssml" }

          it 'executes an Output with the URL' do
            component = Punchblock::Component::Output.new({render_document: {value: url, content_type: "application/ssml+xml"}})
            expect_component_execution component
            subject.play_url url
          end
        end
      end
    end
  end
end
